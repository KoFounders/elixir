# Dockerfile
FROM bitwalker/alpine-elixir as build

# install build dependencies
RUN apk add --update git

# prepare build dir
RUN mkdir /app
WORKDIR /app

# install hex + rebar
RUN mix do local.hex --force, local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# build release
COPY lib lib
RUN mix compile
RUN mix release

FROM alpine:latest AS app

RUN apk upgrade --no-cache && \
apk add --no-cache postgresql-client bash openssl libgcc libstdc++ ncurses-libs

RUN mkdir /app
WORKDIR /app
USER nobody

COPY --chown=nobody --from=build /app/_build/prod/rel/weber .

ENV REPLACE_OS_VARS=true
ENV HTTP_PORT=4000 BEAM_PORT=14000 ERL_EPMD_PORT=24000
EXPOSE $HTTP_PORT $BEAM_PORT $ERL_EPMD_PORT

ENTRYPOINT ["/app/bin/weber", "start"]