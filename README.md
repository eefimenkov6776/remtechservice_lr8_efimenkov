# Лабораторная работа №8

Вариант 8. Гарантийное обслуживание (внутренняя гарантия).

Для проверки выбранной среды используется PostgreSQL 17 и тестовая база данных `remtechservice_lr8_efimenkov`.

## Структура репозитория

- `db/smoke_test.sql` — SQL-запрос для проверки подключения к базе данных;
- `scripts/check-postgres.ps1` — скрипт запуска проверки;
- `evidence/smoke-test.txt` — результат выполненного теста.

## Подготовка среды

1. Установить PostgreSQL 17.
2. Убедиться, что утилита `psql` доступна из командной строки.
3. Создать базу данных:

```sql
CREATE DATABASE remtechservice_lr8_efimenkov;
```

4. Открыть PowerShell в корневой папке проекта.

5. Задать параметры подключения:

```powershell
$env:PGHOST="localhost"
$env:PGPORT="5432"
$env:PGDATABASE="remtechservice_lr8_efimenkov"
$env:PGUSER="postgres"
$env:PGPASSWORD="пароль_пользователя_postgres"
```

## Проверка подключения

Запустить:

```powershell
.\scripts\check-postgres.ps1
```

При успешной проверке в выводе должна присутствовать строка:

```text
LR8 connection OK
```

Результат выполнения сохраняется в:

```text
evidence/smoke-test.txt
```
