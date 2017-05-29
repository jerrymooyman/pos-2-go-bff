FROM ubuntu:latest

MAINTAINER Marcelo Gonçalves <marcelocg@gmail.com>

# Elixir requires UTF-8
RUN apt-get update && apt-get upgrade -y && apt-get install locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# update and install software
RUN apt-get install -y curl wget git make sudo \
    # download and install Erlang apt repo package
    && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && dpkg -i erlang-solutions_1.0_all.deb \
    && apt-get update \
    && rm erlang-solutions_1.0_all.deb \
    # For some reason, installing Elixir tries to remove this file
    # and if it doesn't exist, Elixir won't install. So, we create it.
    # Thanks Daniel Berkompas for this tip.
    # http://blog.danielberkompas.com
    && touch /etc/init.d/couchdb \
    # install latest elixir package
    && apt-get install -y elixir erlang-dev erlang-dialyzer erlang-parsetools \
    # install ncurses and then symlink to a version 6, which is not currently avaiable for ubuntu
    && apt-get install -y libncurses5-dev libncursesw5 libncursesw5-dev \
    && ln -s /lib/x86_64-linux-gnu/libncursesw.so.5  /lib/x86_64-linux-gnu/libncursesw.so.6 \
    # clean up after ourselves
    && apt-get clean

ENV PHOENIX_VERSION 1.2.1

# install the Phoenix Mix archive
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez
RUN mix local.hex --force \
    && mix local.rebar --force

# install Node.js (>= 6.0.0) and NPM in order to satisfy brunch.io dependencies
# See http://www.phoenixframework.org/docs/installation#section-node-js-5-0-0-
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs

WORKDIR /code


# Custom application settings
ENV VERSION 0.0.1
ENV MIX_HOST 4000
EXPOSE $MIX_HOST

RUN mkdir /app
WORKDIR /app
COPY ./rel/pos2gobff/releases/$VERSION/pos2gobff.tar.gz /app/pos2gobff.tar.gz
RUN tar -zxvf pos2gobff.tar.gz

WORKDIR /app/releases/$VERSION
ENTRYPOINT ["./pos2gobff.sh"]
# Start up in 'foreground' mode by default so the container stays running
CMD ["foreground"]

