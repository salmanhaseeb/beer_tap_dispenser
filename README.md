# README

Clone the repository

```sh
git clone git@github.com:salmanhaseeb/beer_tap_dispenser.git
```

Run bundle command and setup the project.

```sh
bundle install
rails db:create db:migrate
```

I have already created an admin in the seed file with an API key.

```sh
rails db:seed
```

Run the project.

```sh
rails server
```

To test the application.

```sh
rspec
```

# Technical Decisions

## 1. Authentication

I have added basic API authentication for the admins for admin-related activities. This is not done using `Devise` as I didn't want the app to use anything that is not suitable. This is a very basic implementation as the only task for the admin is to create dispenser, refill it and do some initial settings, so no session is needed.

## 2. Code Quality

I have used `Rubocop` Gem to make sure the code is of the highest quality.

## 3. Testing

I have used the most commonly used gems `rspec`, `faker`, and `factory_bot`. All the services, controllers and models are tested.

## 4. Service/Object Design Pattern

I have used services where needed.

## API Endpoints

The video demo is here.

https://watch.screencastify.com/v/yDLoYTut0AVZKA1uuqC4
