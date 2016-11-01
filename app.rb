require "sinatra"

get "/" do
  "Alert!"
end

get "/task" do
  system("bundle exec pushpop jobs:run_once --file alert.rb")
end
