require "bundler/setup"
require "sinatra"
require "sinatra/activerecord"
require "date"

enable :sessions

Bundler.require

# ActiveRecord models
class User < ActiveRecord::Base
  has_many :meal_logs
end

class MealLog < ActiveRecord::Base
  validates :meal_date, presence: true
  belongs_to :user
end

def meal_params
  {
    user_id: params[:user_id],
    breakfast: params[:breakfast],
    lunch: params[:lunch],
    dinner: params[:dinner],
    meal_date: params[:meal_date],
  }
end

def meal(meal_log)
  b = meal_log.breakfast ? "breakfast" : ""
  l = meal_log.lunch ? "lunch" : ""
  d = meal_log.dinner ? "dinner" : ""

  return [b, l, d].reject(&:empty?).join(", ")
end

get "/" do
  if User.count.zero?
    @mess_users = ["Nitheesh", "Pranav", "Abhiraj", "Rahul", "Aswin", "Demo", "Vishak"]
    @mess_users.each do |user|
      User.create(name: user)
    end
  end
  @users = User.all
  erb :index
end

get "/meal_logs" do
  user_id = params[:user_id]

  @meal_logs = MealLog.joins(:user).select(:breakfast, :lunch, :dinner, :meal_date).where("users.id = ?", user_id)
  erb :meal_logs
end

post "/meal_log" do
  @meal_log = MealLog.new(meal_params)

  if @meal_log.save
    flash[:notice] = "You have successfully logged #{meal(@meal_log)} for #{@meal_log.meal_date.strftime("%b-%d")}"
    redirect "/"
  else
    flash[:error] = @meal_log.errors.full_messages
    redirect "/"
  end
end
