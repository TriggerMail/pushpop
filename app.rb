require "sinatra"

get "/" do
  "Alert!"
  system("bundle exec pushpop jobs:run_once --file alert.rb")
end
