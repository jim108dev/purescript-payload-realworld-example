# Purescript Payload RealWorld Example

This is a learning project in order to set up a REST API with [PureScript Payload](https://github.com/hoodunit/purescript-payload) and [PostgreSQL](https://www.postgresql.org). The specification follows

- [API Spec](https://github.com/gothinkster/realworld/tree/master/api)

## Install

1. Install [PureScript](https://www.purescript.org/).

1. Install repository 's software:

    1. Clone the repository

    1. Run:

    ```sh
    npm install
    spago install
    spago build
    ```

1. Database Setup:
   1. Install PostgreSQL.
   1. Set up a database called `conduit`. An example script can be found under [sql/CreateDB.sql](./sql/CreateDB.sql). Change [config/Server/Dev.json](./config/Server/Dev.json) accordingly.
   1. Install Database function `timestamp_to_char` under [sql/Functions.sql](./sql/Functions.sql), either the production or mock version for unit tests.
   1. Run `spago run -m Test.ResetTables` creating empty tables.
   1. Run `Function or`spago run -m Test.Main` for table creation with unit test data.

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
