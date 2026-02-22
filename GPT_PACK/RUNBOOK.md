# RUNBOOK（故障排除/操作手冊）

## Telegram 不回

1. 先看 channel health：
   ```bash
   openclaw status --deep
   ```
2. 確認 DM/群組 policy：
   - dmPolicy（DM 是否需要 allowlist/pairing）
   - groupPolicy（群組是否 allowlist）
3. 跟隨 log 看有沒有 inbound：
   ```bash
   openclaw logs --follow
   ```

## GitHub 自動備份

- 備份腳本：`backup/backup_to_github.sh`
- 由 LaunchAgent 定時執行（每 6 小時）
- Log：
  - `/tmp/openclaw-github-backup.out.log`
  - `/tmp/openclaw-github-backup.err.log`

手動立刻備份：
```bash
/Users/vercent/.openclaw/workspace/backup/backup_to_github.sh
```

## iMessage（BlueBubbles）

- OpenClaw 連 BlueBubbles 需要 BlueBubbles Web API 可用
- 若遇到 fetch failed：
  1) 先用 curl 測 ping（需帶 password query）：
     ```bash
     curl -sS "http://127.0.0.1:<PORT>/api/v1/ping?password=<PASSWORD>"
     ```
  2) 若 OpenClaw 端無法穩定帶上 password，可用本機 proxy（見 `bluebubbles/`）
