class UsersController < ApplicationController
  def index
    # render plain: User.all.map { |user| user.to_formatted_string }.join("\n")
  end

  def new
    render "new"
  end

  def create
    User.create!(first_name: params[:first_name],
                 last_name: params[:last_name],
                 email: params[:email],
                 password: params[:password])
    redirect_to "/"
    #render plain: "A new account is created succesfully with ID_NO #{new_user.id}"
  end

  def login
    render plain: User.where("email = ? and password = ? ", params[:email], params[:password]).exists?
  end
end
