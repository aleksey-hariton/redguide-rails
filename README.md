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
**Installation with Docker**

1. Install 
   - Docker: https://docs.docker.com/engine/installation/
   - Docker-compose: https://docs.docker.com/compose/install/
2. Clone this repo
3. Run the command: `bin/setup_with_docker` - it will copy database.yml secrets.yml .env files from examples. _Note_: at
this step you can modify credential information, such as MySQL root password, RedGuide admin user and so on.
4. Run database container: `docker-compose up -d db` - it may take some seconds to start MySQL server.
5. Prepare database: `docker-compose run redguide rake db:create db:setup`
6. Run RedGuide container: `docker-compose up redguide`

Now you have:
  - RedGuide: http://127.0.0.1:3000
  - MySQL instance: 127.0.0.1:13306

**Manual installation**
1. Clone this repo
2. Install mysql client package if you are going to store data in mysql database
3. Install rvm: https://rvm.io/
4. Using rvm create a custom gemset for this project
```sh
  rvm gemset create <gemsetname>
  rvm gemset use <gemsetname>
```
5. Install bundle gem:
```sh
  gem install bundle
```
6. Switch to the project directory and run the command below:
```sh
  cd <path_to_project>
  bundle install
```
7. copy .env .secret .database *.yml example files
8. Configure .secret file by editing credentials
9. Configure database connection, create dev, test and prod databases if needed
10. Type bellow commands to generate database structure and fill it with initial data
```sh
  rake db:migrate
  rake db:seed
```
11. Сlone redguide-cli: https://github.com/aleksey-hariton/redguide-cli.git
12. Initiate RedGuide cli config file, that will be placed in ~/.redguide.yml to access redguide:
```sh
  http://localhost:3000 --user user@example.com --password 123456789
```
Author
------

Aleksey Hariton (aleksey.hariton@gmail.com)
