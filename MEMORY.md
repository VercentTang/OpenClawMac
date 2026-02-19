# MEMORY.md - 長期記憶（Vercent）

> 原則：只記「未來會反覆用到、能提升協作效率」的資訊；以繁體中文維護。

## 核心身分與偏好

- Vercent 位於台灣，偏好 **全程繁體中文**。
- 回覆風格：分析＋務實、可執行、步驟清楚；討厭含糊理論與過度教學。
- 與 AI 的合作方式：把 AI 當「資深技術助理/協作工程師」，迭代式改進（refine → test → refine）。

## 專業領域（主要）

- 產業：半導體化學製造（品質工程與數位化）。
- 常見主題：
  - SAP QM 自動化、檢驗計畫 (Inspection Plan) 建立/修改
  - MIC（Master Inspection Characteristic）對應與 mapping
  - LIMS 整合邏輯、工廠 workflow automation
  - SPC / OOB 統計偵測規則（含 Western Electric rules）
  - 資料可追溯性（traceability）、多系統整合（SAP ↔ LIMS ↔ Lab system）
  - Excel VBA + SAP GUI scripting（大量使用）、Access DB、Python 自動化
  - 取樣邏輯（PQL、十進位/四捨五入規則）
- 對 AI 的期望：解法要 deterministic、提供 step-by-step、理解 workflow context，不只語法。

## 技術棧與工具習慣

- Primary：Excel VBA（複雜自動化）、SAP GUI scripting、Access、Python automation
- Secondary：Playwright/Selenium 爬取、自動解析/轉換（含 PDF）、AI 輔助分類

## 次要興趣/常用需求

- AI & Agents：本機代理（OpenClaw）、Telegram 整合、插件除錯、模型切換；希望有持久記憶行為。
- 財務：台灣 ETF 長期投資、月投規劃、殖利率 vs 成長、退休估算；偏好實務推算勝於學術金融。
- 機車（高興趣）：Honda Monkey 125、Super Cub C125、Vespa；日本改裝品與海運/物流。
  - 已提供多份維修/使用手冊 PDF 節錄（含 C125 保養重點、Honda Smart Key/ABS 警告、Kawasaki 手冊章節如電系/DFI/懸吊等），日後可用來快速查規格/扭力/故障排除。
- 設計：貼紙/海報、AI 生圖、Illustrator/Canva 編修。
- 語言應用：旅遊翻譯、刺青溝通翻譯、網購溝通、商務 email。

## 記憶優先順序

- 高優先：進行中的專案脈絡、檔案結構/命名規範、重複使用的自動化邏輯、語氣/格式偏好
- 中優先：旅遊計畫、購買清單
- 低優先：閒聊話題

## OpenClaw / Tailscale 教訓（重要）

- Control UI 在 **非 localhost 的 HTTP** 會被擋（1008）：必須用 **HTTPS** 或 **localhost**。
- `gateway.bind=tailnet` 可能導致 **127.0.0.1 不再監聽**，使 localhost UI 連不上，且若 Tailscale Serve proxy 仍指向 127.0.0.1 會出現 **502**。
- 最穩的遠端 Control UI 架構：**Windows gateway 維持 localhost 可用（bind=auto）+ Tailscale Serve 提供 tailnet HTTPS**，所有遠端/跨機器都用 `https://<host>.ts.net/` 進入。
- token missing 與 pairing required 是兩件事：
  - token missing → 提供 gateway token（`#token=` 或 UI settings）
  - pairing required → 用 `openclaw devices approve <requestId>` 批准裝置
