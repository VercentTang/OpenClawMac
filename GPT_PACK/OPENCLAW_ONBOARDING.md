# OpenClaw Onboarding（Vercent / macOS）

## 目的

這份文件是給「另一個 GPT / 助理」快速理解我（Vercent）如何在 macOS 上使用 OpenClaw，以及常見操作方式。

## 環境

- OS：macOS
- OpenClaw Gateway：本機 LaunchAgent 方式常駐
- Control UI（本機）：http://127.0.0.1:18789/
- Workspace：`/Users/vercent/.openclaw/workspace`
- 主要 channels：
  - Telegram（bot）
  - iMessage：透過 BlueBubbles（本機）

## 常用指令（Mac）

- 檢查狀態：
  ```bash
  openclaw status
  ```

- 深度檢查（包含 channels health）：
  ```bash
  openclaw status --deep
  ```

- 即時看 log：
  ```bash
  openclaw logs --follow
  ```

- Gateway 服務：
  ```bash
  openclaw gateway status
  openclaw gateway start
  openclaw gateway restart
  openclaw gateway stop
  ```

## 工作習慣 / 風格

- 偏好繁體中文
- 希望一步一步來（不要一次丟一堆）
- 修設定的標準流程：改 config → restart → status --deep → logs
