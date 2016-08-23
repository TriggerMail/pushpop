# pushpop
This is the repo to use pushpop to send alerts.

Pushpop is a framework for scheduled integration between services.  We can use it to query against keen, and generate alerts to send to slack or pagerduty.
The service is written in Ruby.  The official link is: http://pushpop.keen.io/.  Some useful links are:

https://github.com/pushpop-project/pushpop

https://github.com/pushpop-project/pushpop-keen

https://github.com/pushpop-project/pushpop-slack


To run the programs in this repo locally, you need to install Ruby, Gem first.

To run the alert directly, the command is:

  bundle exec pushpop jobs:run_once --file alert.rb

This will send a message to slack.

To run a web service, the command is:

  bundle exec ruby app.rb -p 8080

Then you can open http://localhost:8080/ in browser to trigger the same alert.

To deploy the service to GCE, the command is:

  gcloud config set project triggermail-datascience
  
  gcloud app deploy ruby.yaml
