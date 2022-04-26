FROM ruby:2.5.1-alpine

WORKDIR /sidekiq

COPY Gemfile* ./
COPY config.ru .

RUN bundle update sidekiq
RUN bundle install

CMD rackup config.ru -o 0.0.0.0 -p 3030 -q
