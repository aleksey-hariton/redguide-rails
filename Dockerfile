FROM ruby:2.3.3

RUN apt-get update -qq && apt-get install -y build-essential mysql-client libmysqlclient-dev nodejs

RUN mkdir /redguide-rails
WORKDIR /redguide-rails
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install 

ADD . /redguide-rails
