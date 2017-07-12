# he-blog
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
