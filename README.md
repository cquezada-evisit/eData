# EdataEav Gem

This gem provides a way to migrate NoSQL documents to a SQL-based EAV (Entity-Attribute-Value) model. The gem includes services for migrating documents and building JSON structures from the EAV model.

## Environment Variables

Make sure to set the following environment variables: (.env file)

```sh
EDATA_DB_ADAPTER=mysql2
EDATA_DB_ENCODING=utf8
EDATA_DB_POOL=5
EDATA_DB_USERNAME=root
EDATA_DB_PASSWORD=your_secret_db_password
EDATA_DB_HOST=your_host_address
EDATA_DB_PORT=3306
EDATA_DB_DEVELOPMENT_DATABASE=edata_development
EDATA_DB_TEST_DATABASE=edata_test
EDATA_DB_PRODUCTION_DATABASE=edata_production
```

## Docker Setup

### Building the Docker Container

To build the Docker container, run the following command:

```sh
docker-compose build
```

### Running the Docker Container

To start the Docker container, use the following command:

```sh
docker-compose up -d
```

## Database Setup

### Creating and Migrating the Database

You need to run rake tasks to create and migrate the database. Ensure that you have set the environment variables correctly.

#### Setup Database

Run the following rake task to create and migrate the database:

```sh
docker-compose run edata_eav bundle exec rake edata_eav:setup
```

## Running Tests

To run the tests, use the following command:

```sh
docker-compose run edata_eav bundle exec rspec
```
