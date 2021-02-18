# PureScript Payload RealWorld Example

This is a learning project in order to set up a REST API with [PureScript Payload](https://github.com/hoodunit/purescript-payload) and [PostgreSQL](https://www.postgresql.org). The specification follows

- [RealWorld API Spec](https://github.com/gothinkster/realworld/tree/master/api)

## Install

1. Install [PureScript](https://www.purescript.org/).

1. Install repository 's software:

    The current [purescript-selda](https://github.com/Kamirus/purescript-selda) does not update correctly and does not support offsets ([issue](https://github.com/Kamirus/purescript-selda/issues/54)). Please use version v0.1 until it gets resolved.

    1. Run:

    ```sh
    # This repo
    git clone https://github.com/jim108dev/purescript-payload-realworld-example.git
    
    cd purescript-payload-realworld-example
    # until selda issues are resolved:
    git checkout tags/v0.1
    
    npm install pg decimal.js xhr2 jsonwebtoken
    spago install
    spago build
    ```

### Development/Test Mode

Please choose if you want to run the server in development/test (Dev) mode or in production mode (Prod). *Dev* operates with fixed timestamps which is required for the automated tests to run. *Prod* operates with the current system time.

1. Database Setup:
   1. Install PostgreSQL.
   1. `sql/CreateDB.sql`: Execute commands which set up a database called `conduit`.
   1. `config/Server/{Dev|Prod}.json`: Change config files according to your db setup.
   1. `sql/Functions.sql`: Execute commands which set up functions/triggers for *Prod*.
   1. `sql/ResetTables.sql`: Activate the current timestamps by uncommenting `-- TIMESTAMP` for *Prod*. This file can be executed with:

    ```sh
    spago run -m Test.ResetTables
    ```

1. Jwt: `config/Server/Prod.json`: Change the token's secret key for *Prod*.

1. Server: `src/Server/Main.purs`: Set the configuration file accordingly.

1. Optional: Install [HTTPie](https://httpie.io) and [httpie-jwt-auth](https://github.com/teracyhq/httpie-jwt-auth) for testing via command line.

1. Optional: Install a frontend like [Real World Halogen](<https://github.com/thomashoneyman/purescript-halogen-realworld>).

## Usage

1. Run the server:

    ```sh
    spago run 
    ```

1. [API-SPEC.md](./API-SPEC.md) lists HTTPie test calls to every request.

1. Run a frontend.

## Development

1. Run the unit tests  

    ```sh
    spago run -m Test.Main
    ```

[APPROACH.md](./APPROACH.md) contains some comments about the decisions which were made.
