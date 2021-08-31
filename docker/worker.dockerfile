FROM maxhollmann/podify-base:dev

CMD ["bundle", "exec", "sidekiq", "-c", "3"]
