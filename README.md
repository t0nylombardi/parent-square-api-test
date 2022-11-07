# Parent Square Api Challenge. 

## Setup 

### 1

- `git clone git@github.com:t0nylombardi/parent-square-api-test.git`
- `cd parent-square-api-test`
- `bin/rails db:create db:migrate`
- `have a sip of coffee`

### 2 Ngrok

To get the callback to work, you need to install Ngrok see: https://ngrok.com/docs/getting-started
- `ngrok http 3000`
- more on ngrok later..... stay tuned. 

### 3 The best part? 
There are two url endpoints `/message` && `/callback`

message takes two params, `phone_number` && `message`:

```shell
  curl --location --request POST 'localhost:3000/v1/message' \
    --header 'Content-Type: application/json' \
    --data-raw '{
    "phone_number": "9143195275",
    "message": "This is my message xxxx"
    }'
```

callback takes two parameters `message_id` && `status` 

This enpoint will update the corrisponding message_id with the status that is recieved. 

```shell
  curl --location --request POST 'api.localhost:3000/v1/callback' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "status": "failed", 
        "message_id": "ea736f97-d49b-40db-8a7b-be8bef9542e8"
    }'
```
To get callback enpoint to work, the callback url will need to be changed to what ngrok gives when executed.

```ruby
# app/services/message_service.rb
body = {
        to_number: @phone_number,
        message: @message,
        callback_url: 'https://97af-69-118-172-165.ngrok.io/v1/callback'
      }
```


## Docker setup
```
cp .env.example .env
docker compose build
docker compose run --rm web bin/rails db:setup
```

## Running the Rails app
```
docker compose up
```

## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
docker compose exec web bin/rails c
```

When no container running yet, start up a new one:
```
docker compose run --rm web bin/rails c
```

## Running tests
```
docker compose run --rm web bin/rspec
```
