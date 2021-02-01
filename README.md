# Purescript Payload RealWorld Example

This is a learning project in order to set up a REST API with [PureScript Payload](https://github.com/hoodunit/purescript-payload) and [PostgreSQL](https://www.postgresql.org). The specification follows

- [API Spec](https://github.com/gothinkster/realworld/tree/master/api)

## Install

1. Install [PureScript](https://www.purescript.org/).

1. Install repository 's software:

    1. Run:

    ```sh
    # Clone the patched version of payload
    git clone https://github.com/jim108dev/purescript-payload.git
    # This repo
    git clone https://github.com/jim108dev/purescript-payload-realworld-example.git
    cd purescript-payload-realworld-example
    npm install pg decimal.js xhr2
    spago install
    spago build
    ```

1. Database Setup:
   1. Install PostgreSQL.
   1. Set up a database called `conduit`. An example script can be found under [sql/CreateDB.sql](./sql/CreateDB.sql). Change [config/Server/Dev.json](./config/Server/Dev.json) accordingly.
   1. Install the database function `timestamp_to_char` under [sql/Functions.sql](./sql/Functions.sql), either the production or mock version in order to run the tests.
   1. Create tables with

    ```sh
    spago run -m Test.ResetTables
    # or for tables with test data
    spago run -m Test.Main
    ```

1. Jwt:
   Change the token's secret key in [config/Server/Dev.json](./config/Server/Dev.json). (In order to run the automated tests, `secret` must be kept in place.)

1. Optional: Install [HTTPie](https://httpie.io) for testing via command line.

1. Optional: Install a frontend like [Real World Halogen](<https://github.com/thomashoneyman/purescript-halogen-realworld>).

## Usage

1. Run the server:

```sh
spago run 
```

1. [API-SPEC.md](./API-SPEC.md) lists HTTPie test calls to every request.

1. Run a frontend.

## Development

[APPROACH.md](./APPROACH.md) contains some comments about the decisions which were made.
