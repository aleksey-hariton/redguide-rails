FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential mysql-client libmysqlclient-dev nodejs

ENV APP_HOME /redguide-rails

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install
