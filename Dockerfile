FROM ruby:2.7.4-bullseye

RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client python3 python3-pip ffmpeg
RUN npm install -g yarn


RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle config set clean true && \
    bundle config set deployment true && \
    bundle config set no-cache true && \
    bundle config set without 'development test' && \
    bundle install

COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock
RUN yarn install --production

COPY . /app

RUN chmod +x /app/docker/entrypoint.sh
ENTRYPOINT ["/app/docker/entrypoint.sh"]
EXPOSE 3000

ENV PATH="/app/bin:${PATH}"
ENV RAILS_ENV=production

# Precompile assets
RUN webpack

RUN pip3 install youtube-dl

ENV RAILS_SERVE_STATIC_FILES="yes"
ENV PORT=3000

CMD ["start-server"]
