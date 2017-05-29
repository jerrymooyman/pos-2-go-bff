# Pos2gobff
This is an Elixir implementation of a GraphQL server
Provisions have been made to allow it to run as a docker container

## Get running

To start the app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
  
## Create Release

compress, compile and create a release
  * `$ MIX_ENV=prod mix do phoenix.digest, compile, release`

should then be able to run the release with:
  * `$ rel/hello_phoenix/bin/pos2gobff console`

## Docker

build image
  * `$ docker build -t pos2gobff .`

run container
  * `$ docker run -e PORT=4000 -p 4000:4000 --name pos2gobff -d pos2gobff`

NB: in the dockerfile, I had to add a missing dependency of libncurses5 and symlink it as version 6.
