require "bundler/setup"
require "sinatra"
require "sinatra/activerecord"

Bundler.require

# ActiveRecord models
class User < ActiveRecord::Base
end

class MealLog < ActiveRecord::Base
end

def meal_params
  {
    user_id: params["user_id"],
    breakfast: params["breakfast"],
    lunch: params["lunch"],
    dinner: params["dinner"],
    meal_date: params["meal_date"]
  }
end


get "/" do
  @users = User.all
  erb :index
end

post "/meal_log" do
  @meal_log = MealLog.new(meal_params)
  if @meal_log.save
    redirect "/"
    puts "success"
  else
    puts "failed"
  end
end
