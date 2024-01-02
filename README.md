AlloyDB Local
---

This is a tool for easily and quickly building AlloyDB.

## Description

This tool uses Vagrant to build AlloyDB.
All necessary tools are installed within the VM, allowing for easy and quick construction.

Note: This is intended for use as a local development environment. Do not use in a production environment.

## Usage

1. Launch

    To launch AlloyDB, execute the following command:

    ```shell
    vagrant up
    ```

2. Initial Setup (Only for the First Launch)

    On the first launch only, execute the following to set the password for PostgreSQL's `postgres` user:

    ```shell
    # Execute on the host
    vagrant ssh

    # Execute inside the VM
    sudo alloydb database-server start
    sudo docker exec -it pg-service psql -h localhost -U postgres

    # Execute inside the `pg-service`
    ALTER USER postgres WITH PASSWORD '${PASSWORD}';
    ```

3. Connect to DB

    Connect from the host using the following connection information:

    | | Value |
    | --- | --- |
    | Host | alloydb.localhost.com |
    | Port | 5432 |
    | User | postgres |
    | Password | ${PASSWORD} set in step 2 |

4. Termination

    To terminate AlloyDB, execute the following command:

    ```shell
    vagrant halt
    ```
