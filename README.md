# EdataEav Gem

This gem provides a way to migrate NoSQL documents to a SQL-based EAV (Entity-Attribute-Value) model. The gem includes services for migrating documents and building JSON structures from the EAV model.

## Environment Variables

Make sure to set the following environment variables: (.env file)
Note: Consider using a remote database such as a Google Cloud SQL instance

```sh
EDATA_DB_ADAPTER=mysql2
EDATA_DB_ENCODING=utf8
EDATA_DB_POOL=5
EDATA_DB_USERNAME=root
EDATA_DB_PASSWORD=your_password
EDATA_DB_HOST=your_secret_key
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
docker-compose up
```

## Database Setup

### Creating and Migrating the Database

You need to run rake tasks to create and migrate the database. Ensure that you have set the environment variables correctly.

#### Creating the Database

Run the following rake task to create the database:

```sh
docker-compose run edata_eav bundle exec rake edata_eav:create_db
```

#### Migrating the Database

Run the following rake task to migrate the database:

```sh
docker-compose run edata_eav bundle exec rake edata_eav:migrate_db
```

## Running Tests

To run the tests, use the following command:

```sh
docker-compose run edata_eav bundle exec rspec
```
