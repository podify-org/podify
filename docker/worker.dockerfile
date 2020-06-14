FROM maxhollmann/podify-base:preview

CMD ["bundle", "exec", "sidekiq", "-c", "3"]
