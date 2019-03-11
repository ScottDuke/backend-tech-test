
Solution is using Ruby 2.5.1 and Rails 5.2.2

# Setup
```
  bundle install
  rails db:migrate
```


## How to import data
Run the following `rake import:video_data`

## Running tests
`bundle exec rspec spec/`

## To run
`rails s`

### Example queries
`http://localhost:3000/search?artist=reece%20jacob`  
`http://localhost:3000/search?city=Bangalore`  
`http://localhost:3000/search?song_name=Words%20Fail`

# What else I would do
- Import rake task
  - add additional test for when the video data doesn't contain song information
  - progress overview for importing the video data
- Tests
  - Model tests
  - finish controller tests
- Param validation
- Make use of factories, faker for testing
- move the controller specs to request specs
- namespace routes so instead of `/search` it would be `/api/v1/search`
- return results in either xml or json
- Improve scope names
- Model validation to stop same video uid from being added for example
  

# The Test
We have the following JSON file hosted on S3 that contains some metadata about videos of Sofar performances:

https://s3-eu-west-1.amazonaws.com/sofar-eu-1/video_data.json

We would like to see a simple application that ingests this data somehow (it is up to you how you process it), and we would like you to design an API route that allows querying of this data by the video's song name, artist or the city the video was performed in.

We would like you to spend no more than a couple of hours on this task.

# Notes

* We would like to see your journey, so please use your git commits to tell us a story
* We love TDD so some kind of test suite is a plus, we aren't expecting a full test suite
* If you'd like to show off your front-end knowledge, then feel free to create a simple frontend using any modern frontend framework.
* If you can't achieve everything in the time use the readme to tell us what you would do next.

# Deliverables

Please clone this repository add some code and update the Readme with how to run your app and import.

Then upload to somewhere like github or bitbucket (has free private repos) and share with us, or create a zip archive and send to us.
