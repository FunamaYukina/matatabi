FROM ruby:2.6
ENV LANG C.UTF-8

RUN apt-get update -qq
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs

RUN mkdir /matatabi_app
WORKDIR /matatabi_app

ADD Gemfile /matatabi_app/Gemfile
ADD Gemfile.lock /matatabi_app/Gemfile.lock

RUN gem install bundler
RUN bundle install
ADD . /matatabi_app