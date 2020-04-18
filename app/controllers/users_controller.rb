class UsersController < ApplicationController
  skip_before_action :ensure_logged_in

  def index
    # render plain: User.all.map { |user| user.to_formatted_string }.join("\n")
  end

  def new
    render "new"
  end

  def create
    new_user = User.new(first_name: params[:first_name],
                        last_name: params[:last_name],
                        email: params[:email],
                        password: params[:password])

    if new_user.save
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(",")
      redirect_to new_user_path
    end
    #render plain: "A new account is created succesfully with ID_NO #{new_user.id}"
  end

  def login
    render plain: User.where("email = ? and password = ? ", params[:email], params[:password]).exists?
  end
end
