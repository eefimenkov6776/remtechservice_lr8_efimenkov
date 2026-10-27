$ErrorActionPreference = "Stop"

$required = @("PGHOST","PGPORT","PGDATABASE","PGUSER","PGPASSWORD")
foreach ($name in $required) {
    $value = [Environment]::GetEnvironmentVariable($name, "Process")
    if ([string]::IsNullOrWhiteSpace($value)) {
        throw "Не задана переменная среды $name"
    }
}

$psql = Get-Command psql -ErrorAction SilentlyContinue
if (-not $psql) {
    throw "psql не найден. Добавьте каталог bin PostgreSQL в PATH."
}

$root = Split-Path -Parent $PSScriptRoot
$sqlFile = Join-Path $root "db\smoke_test.sql"
$evidenceDir = Join-Path $root "evidence"
$evidenceFile = Join-Path $evidenceDir "smoke-test.txt"

if (-not (Test-Path $sqlFile)) {
    throw "Не найден файл $sqlFile"
}

New-Item -ItemType Directory -Path $evidenceDir -Force | Out-Null

& psql `
    --host=$env:PGHOST `
    --port=$env:PGPORT `
    --dbname=$env:PGDATABASE `
    --username=$env:PGUSER `
    --file=$sqlFile 2>&1 | Tee-Object -FilePath $evidenceFile

if ($LASTEXITCODE -ne 0) {
    throw "Проверка PostgreSQL завершилась с ошибкой."
}
