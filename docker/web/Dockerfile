FROM ruby:2.5.0
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs apt-utils mysql-client vim
 
ENV ROOT_PATH /book_recorder
RUN mkdir $ROOT_PATH
WORKDIR $ROOT_PATH
ADD Gemfile $ROOT_PATH/Gemfile
ADD Gemfile.lock $ROOT_PATH/Gemfile.lock
RUN bundle install -j4
ADD . $ROOT_PATH

EXPOSE 3000
