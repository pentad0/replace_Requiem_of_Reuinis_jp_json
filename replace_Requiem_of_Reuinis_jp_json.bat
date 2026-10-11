@echo off
setlocal

REM %1 = 入力ファイル
REM %2 = 置換リスト
REM %3 = 出力ファイル

powershell -NoLogo -NoProfile -Command ^
  "$map = @{};" ^
  "$lines = Get-Content '%2' -Encoding UTF8;" ^
  "for ($i = 1; $i -lt $lines.Count; $i++) {" ^
  "  $parts = $lines[$i] -split \"`t\";" ^
  "  if ($parts.Count -ge 4) {" ^
  "    $key = $parts[2];" ^
  "    $val = $parts[3];" ^
  "    if (![string]::IsNullOrWhiteSpace($key)) { $map[$key] = $val }" ^
  "  }" ^
  "}" ^
  "$txt = Get-Content '%1' -Raw -Encoding UTF8;" ^
  "foreach ($k in $map.Keys) { $txt = $txt.Replace($k, $map[$k]) };" ^
  "$txt | Set-Content '%3' -Encoding UTF8"
