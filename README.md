
## Installation

`bundle install`

`rails db:create`

`rails db:migrate`

## API

* Two endpoints at `/api/twitter` and `/api/search`
* Both endpoints accept a `q` query string such as `?q=healthcare` or `?q=open%20source`
* The `/api/search` also starts an ActiveJob that queries for new tweets in 5 minute
intervals. This ActiveJob isn't backed by a 3rd-party library and stores the job in
memory; the jobs have to be added back if the process crashes.
* In heroku, I populated the tweets using curl to hit the `/api/search` endpoint
