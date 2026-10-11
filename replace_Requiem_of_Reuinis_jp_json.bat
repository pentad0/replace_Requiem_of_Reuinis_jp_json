@echo off
setlocal

REM 引数:
REM %1 = 入力ファイル
REM %2 = 置換リスト（No.<TAB文字>クラス<TAB文字>日本語訳テキスト<TAB文字>修正案<TAB文字>コメント）
REM %3 = 出力ファイル

powershell -NoLogo -NoProfile -Command ^
  "$map = @{}; " ^
  "Get-Content '%2' -Encoding UTF8 | ForEach-Object { " ^
  "  $parts = $_ -split \"`t\"; " ^
  "  if ($parts.Count -ge 2) { " ^
  "    $key = $parts[2]; " ^
  "    $val = $parts[3]; " ^
  "    if (![string]::IsNullOrWhiteSpace($key)) { $map[$key] = $val } " ^
  "  } " ^
  "}; " ^
  "$txt = Get-Content '%1' -Raw -Encoding UTF8; " ^
  "foreach ($k in $map.Keys) { $txt = $txt.Replace($k, $map[$k]) }; " ^
  "$txt | Set-Content '%3' -Encoding UTF8"
