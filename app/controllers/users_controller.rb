class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_formatted_string }.join("\n")
  end

  def create
    new_user = User.create!(name: params[:name], email: params[:email], password: params[:password])
    render plain: "A new account is created succesfully with ID_NO #{new_user.id}"
  end

  def login
    render plain: User.where("email = ? and password = ? ", params[:email], params[:password]).exists?
  end
end
