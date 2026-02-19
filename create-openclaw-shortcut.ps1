$src = 'C:\Users\taiwa\.openclaw\workspace\start-openclaw-ui.cmd'
$desktop = [Environment]::GetFolderPath('Desktop')
$lnk = Join-Path $desktop 'OpenClaw UI (Tailnet HTTPS).lnk'

$w = New-Object -ComObject WScript.Shell
$s = $w.CreateShortcut($lnk)
$s.TargetPath = $src
$s.WorkingDirectory = Split-Path $src
$s.WindowStyle = 1
$s.Description = 'Start OpenClaw Gateway + Tailscale Serve and open Control UI'
$s.Save()

Write-Host "Created shortcut: $lnk"
