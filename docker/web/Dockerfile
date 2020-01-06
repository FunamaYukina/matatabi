FROM ruby:2.6.5
ENV LANG C.UTF-8

RUN apt-get update -qq
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

RUN mkdir /matatabi_app
WORKDIR /matatabi_app

ADD Gemfile /matatabi_app/Gemfile
ADD Gemfile.lock /matatabi_app/Gemfile.lock
ENV PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
RUN yarn add jquery popper.js bootstrap
RUN gem install bundler
RUN bundle install