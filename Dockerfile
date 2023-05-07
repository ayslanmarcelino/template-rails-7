# Use the official Ruby image as the base image
FROM ruby:3.1-alpine

# Install dependencies
RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn \
  git

# Copy the application files into the container
COPY . /app

# Set the working directory in the container
WORKDIR /app

# Install necessary gems
RUN gem install bundler && bundle install

# Expose port 3000
EXPOSE 3000

# Define the entry point for the container
CMD ["rails", "server", "-b", "0.0.0.0"]
