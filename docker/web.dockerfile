FROM maxhollmann/podify-base

ENV PRECOMPILE_ASSETS="yes"
ENV RUN_MIGRATIONS="yes"
ENV RAILS_SERVE_STATIC_FILES="yes"
ENV PORT=3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
