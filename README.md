RedGuide Rails Application
=======================

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.3
- Rails 5.0.0.1

About
-----

RedGuide - CI tool for support of IaaC (Infrastructure as a Code) and TDI (Test Driven Infrastructure) approaches in you Chef cookbook development.

How to get started
------------------
1. Clone this repo
2. Install mysql client package if you are going to store data in mysql database
3. Using rvm create a custom gemset for this project 
4. Install bundle gem:
```sh
  gem install bundle
```
5. Switch to the project directory and run the command below:
```sh
  bundle install
```
6. copy .env .secret .database *.yml example files
7. Configure .secret file by editing credentials
8. Configure database connection, create dev, test and prod databases if needed
9. Type db:migrate to create the database structure
10. Type db:seed to fill the database with the initial data
11. Сlone redguide-cli: https://github.com/aleksey-hariton/redguide-cli.git
12. Initiate RedGuide cli config file, that will be placed in ~/.redguide.yml to access redguide:
```sh
  http://localhost:3000 --user user@example.com --password 123456789
```

Author
------

Aleksey Hariton (aleksey.hariton@gmail.com)
