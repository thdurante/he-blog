# he-blog
[![Codeship Status for thdurante-repo/he-blog](https://app.codeship.com/projects/c7f48860-4abd-0135-477b-1ebb32b1aa5f/status?branch=master)](https://app.codeship.com/projects/232653)
[![codecov](https://codecov.io/bb/thdurante-repo/he-blog/branch/master/graph/badge.svg?token=jPcrrGH8Is)](https://codecov.io/bb/thdurante-repo/he-blog)

Microblog application developed in the hiring process of HE:labs.

## Setup
In the project's root directory:
```
$ bundle install
$ rails db:create
$ rails db:migrate
```

## Run
In the project's root directory:
```
$ rails s
```

## Env
Create a new `config/application.yml` following this example:
```
CODECOV_TOKEN: <TOKEN>
AWS_REGION: <REGION>
AWS_ACCESS_KEY_ID: <ACCESS_KEY_ID>
AWS_SECRET_ACCESS_KEY: <SECRET_ACCESS_KEY>

test:
  S3_BUCKET_NAME: 'he-blog-test'

development:
  S3_BUCKET_NAME: 'he-blog-development'

production:
  S3_BUCKET_NAME: <BUCKET_NAME>
```

## Deploy
First of all, to config action cable, read the [docs](https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable#deploying-our-application-to-heroku).
Then, in the project's root directory:
```
$ git push heroku master
$ heroku pg:reset
$ heroku run rake db:migrate
$ heroku run rake db:seed
$ figaro heroku:set -e production
```
After the steps above, go to [https://he-blog.herokuapp.com](https://he-blog.herokuapp.com).
Default credentials:
```
Login: teste1@teste.com.br
Password: teste12345

Login: teste2@teste.com.br
Password: teste12345
```
