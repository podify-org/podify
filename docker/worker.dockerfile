FROM maxhollmann/podify-base

CMD ["bundle", "exec", "sidekiq", "-c", "3"]
