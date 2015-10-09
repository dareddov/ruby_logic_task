# ruby_logic_task

## 1. Download and setup appliaction

```bash
git clone git@github.com:dareddov/ruby_logic_task.git
cd ruby_logic_task
bundle install
cp config/database.yml.example config/database.yml # configure access to database
rake db:create db:migrate
```

## 2. Import Users
To import users need xls or xlsx spreedshet.

Command importing
```bash
rake import_users path=file_path
```
Variable file_path is responsible to the path to the file.
example:
```bash
rake import_users path=public/users.xlsx
```
After importing is displayed report.
example: 
```bash
Importing rows: 70
Not importing rows: 0
```
