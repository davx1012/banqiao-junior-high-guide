# 升國中大冒險（板橋升私中決策筆記）

家庭討論用的靜態網頁，主題是從板橋出發、116 學年度（2027 年入學）要讀公立國中還是私立國中。內容包括：

- 公立與私立國中比較
- 會考升學數據
- 三所推薦私中（南山、裕德、延平）
- 入學方式問答、撞期策略
- 時間表、寒假衝刺班規劃
- 全家討論清單

## 網站

- GitHub Pages：https://davx1012.github.io/banqiao-junior-high-guide/
- Cloudflare Pages：https://banqiao-junior-high-guide.pages.dev

## 部署

- **GitHub Pages**：推送到 `main` 後由 GitHub 自動建置。
- **Cloudflare Pages**：由 `scripts/pre-push` Git hook 在推送 `main` 時部署。
  - 部署時先把 `index.html` 與 `img/` 複製到 `dist/`，再執行 `wrangler pages deploy dist`。只公開網站本身，不會上傳 `.git` 等內部檔案。
  - 安裝方式：`cp scripts/pre-push .git/hooks/pre-push`

## 訪客計數器

使用 Supabase（專案 `banqiao-junior-high-guide`，東京）。`supabase/counter.sql` 建立 `page_views` 資料表：

- 開啟 RLS 且沒有 policy，匿名使用者無法直接讀寫
- 只能透過 `increment_page_views`、`get_page_views` 兩個 RPC 函式操作
- 網頁使用 publishable key（公開金鑰）

## 素材

圖示來自 [Microsoft Fluent Emoji](https://github.com/microsoft/fluentui-emoji)（MIT 授權，見 `img/LICENSE-fluentui-emoji.txt`）。

資料整理於 2026-09-13。招生日期與費用請以各校最新公告為準。
