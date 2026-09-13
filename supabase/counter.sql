-- 訪客計數器：一個頁面一列，只能透過下面兩個函式讀寫
create table if not exists public.page_views (
  slug text primary key check (slug in ('banqiao-junior-high-guide')),
  count bigint not null default 0,
  updated_at timestamptz not null default now()
);

-- 開啟 RLS 且不建立任何 policy：匿名使用者無法直接讀寫資料表
alter table public.page_views enable row level security;

-- 計數 +1 並回傳最新數字
create or replace function public.increment_page_views(page_slug text)
returns bigint
language sql
security definer
set search_path = public
as $$
  insert into public.page_views (slug, count)
  values (page_slug, 1)
  on conflict (slug) do update
    set count = public.page_views.count + 1,
        updated_at = now()
  returning count;
$$;

-- 只讀取目前數字（同一個瀏覽器分頁重新整理時使用，不重複計算）
create or replace function public.get_page_views(page_slug text)
returns bigint
language sql
stable
security definer
set search_path = public
as $$
  select coalesce((select count from public.page_views where slug = page_slug), 0);
$$;

revoke all on function public.increment_page_views(text) from public;
revoke all on function public.get_page_views(text) from public;
grant execute on function public.increment_page_views(text) to anon, authenticated;
grant execute on function public.get_page_views(text) to anon, authenticated;
