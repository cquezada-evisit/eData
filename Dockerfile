FROM ruby:2.7-alpine

# Install dependencies
RUN apk add --no-cache build-base libxml2-dev libxslt-dev mysql-dev git

# Set the working directory
WORKDIR /app

# Install bundler 2.4.22, compatible con Ruby 2.7
RUN gem install bundler -v 2.4.22

# Copy the Gemfile, and .gemspec
COPY Gemfile edata_eav.gemspec ./

# Install dependencies
RUN bundle _2.4.22_ install

# Copy the rest of the application files
COPY . .

# Copy the .env and database.yml files
COPY .env config/database.yml ./config/

# Run database setup
CMD ["sh", "-c", "bundle exec rake edata_eav:setup && irb"]
