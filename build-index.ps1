# Builds index.html (GitHub Pages) from bc-tax-remitter.html (artifact source).
# The artifact viewer injects its own <head> wrapper; GitHub Pages needs one in the file,
# most importantly the viewport meta - without it phones render a zoomed-out desktop page.
# Run after every edit to bc-tax-remitter.html, then commit both.
Set-Location $PSScriptRoot
$src = Get-Content -Raw -Encoding utf8 .\bc-tax-remitter.html
$body = $src -replace '(?s)^\s*<title>.*?</title>\s*', ''
$head = @'
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>BC Monthly Tax Remitter</title>
<meta name="description" content="Estimate how much to set aside and remit to CRA each month - 2026 BC and federal tax plus self-employed CPP.">
<meta name="theme-color" media="(prefers-color-scheme: light)" content="#f4f6f4">
<meta name="theme-color" media="(prefers-color-scheme: dark)" content="#131817">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="apple-touch-icon.png">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="apple-mobile-web-app-title" content="Tax Remitter">
</head>
<body>
'@
$out = $head + "`n" + $body + "`n</body>`n</html>`n"
Set-Content -Path .\index.html -Value $out -Encoding utf8
Write-Output ("index.html built: " + (Get-Item .\index.html).Length + " bytes")
