# Podify

Create podcasts from anything youtube-dl can handle.

![Demo](demo.gif)

Podify is a self-hosted service that allows you to download videos and audio from any source supported by [youtube-dl](https://github.com/layer8x/youtube-dl.rb), sort the downloads into feeds, and subscribe to these feeds using your favorite podcast app (I recommend [Podcast Addict](https://play.google.com/store/apps/details?id=com.bambuna.podcastaddict&hl=en) if you're on Android).

## Installation using Docker

Here's a [sample `docker-compose.yml`](docker/docker-compose.example.yml).

## Configuration via Environment Variables

| Variable              | Required | Description                                                                                           |
|:----------------------|:---------|:------------------------------------------------------------------------------------------------------|
| DATABASE_URL          | Yes      | `postgres://` url pointing to postgres database                                                       |
| REDIS_URL             | Yes      | `redis://` url pointing to redis instance                                                             |
| URL_HOST              | Yes      | Where the app will be available, e.g. `https://podify.yourdomain.com`                                 |
| SECRET_KEY_BASE       | Yes      | This is used to encrypt sessions, see [below](#secret_key_base)                                       |
| STORAGE_DIR           | Yes      | Where downloads will be stored                                                                        |
| RAILS_LOG_TO_STDOUT   | No       | Write logs to stdout so they end up in the docker container logs. `"yes"` or `"no"` (default: `"no"`) |
| INITIAL_USER_EMAIL    | No       | Email of user to create at startup                                                                    |
| INITIAL_USER_PASSWORD | No       | Password of user to create at startup                                                                 |
| ENABLE_SIGNUP         | No       | Allow anyone with access to the site to sign up. `"yes"` or `"no"` (default: `"yes"`)                 |

### `SECRET_KEY_BASE`

This is utilized to encrypt and sign sessions. It's recommended that you generate a new one instead of using the one from the example `docker-compose.yml`. You can generate a new one using

    docker run --rm maxhollmann/podify-worker rails secret

## Development

```shell
docker-compose up
bundle install

be sequel -m db/migrate postgres://podify@localhost/podify_development
be sequel -m db/migrate postgres://podify@localhost/podify_test

bin/webpack-dev-server
bundle exec rails s
```
