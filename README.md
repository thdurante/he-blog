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

## Deploy
In the project's root directory:
```
$ git push heroku master
$ heroku run rake db:migrate
```
