FROM ruby:2.5.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    apt-get update -qq && \
    apt-get install -y build-essential libpq-dev apt-utils mysql-client vim curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install nodejs && \
    apt-get update && apt-get install -y yarn
 
ENV ROOT_PATH /book_recorder
RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH
ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock
RUN bundle install -j4
ADD . $ROOT_PATH
RUN yarn install --ignore-engines

EXPOSE 3000
