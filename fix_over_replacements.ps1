
$fixes = @{
    'Icons\.HomePage' = 'Icons.home';
    '\bHomePage:' = 'home:';
    "'HomePage'" = "'Home'";
    '"HomePage"' = '"Home"';
    'Icons\.SearchPage' = 'Icons.search';
    'Icons\.SettingsPage' = 'Icons.settings';
    'SearchPage-svgrepo' = 'search-svgrepo';
    '// Default to HomePage page' = '// Default to Home page';
}

Get-ChildItem -Path "lib" -Filter "*.dart" -Recurse | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $modified = $false
    foreach ($old in $fixes.Keys) {
        if ($content -match $old) {
            $content = $content -replace $old, $fixes[$old]
            $modified = $true
        }
    }
    if ($modified) {
        Set-Content $_.FullName $content -NoNewline
    }
}
