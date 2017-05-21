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
2. Install mysql client package
3. Using rvm create a custom gemset for this project 
4. Install bundle gem:
```sh
  gem install bundle
```
5. Switch to project directory and run this command
```sh
  bundle install
```
6. copy .env .secret .database *.yml example files
7. Configure database connection, create dev, test and prod databases if needed
8. Type db:migrate to create the database structure
9. Type db:seed to fill the database with the initial data
10. Сlone redguide-cli 


Author
------

Aleksey Hariton (aleksey.hariton@gmail.com)
