class Admin::UsersController < Admin::BaseController
    require "csv"
  
    def index
      @users = User.all
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.temporary_password = generate_temporary_password
      @user.password = @user.temporary_password # Set the Devise password to the 6-digit password
      @user.password_confirmation = @user.temporary_password
  
      if @user.save
        SendWelcomeEmailJob.perform_later(@user.id)
        redirect_to admin_users_path, notice: "User created successfully. An email has been sent to the user."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      if @user.has_voted?
        redirect_to admin_users_path, alert: "Cannot delete a user who has already voted."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted successfully."
      end
    end
  
    def import
      if params[:file].present?
        file = params[:file]
        begin
          CSV.foreach(file.path, headers: true) do |row|
            user_data = row.to_hash
            next unless user_data["email"].present? && user_data["name"].present?
  
            user = User.new(
              name: user_data["name"],
              email: user_data["email"],
              role: user_data["role"] || "member",
              has_voted: false
            )
            user.temporary_password = generate_temporary_password
            user.password = user.temporary_password
            user.password_confirmation = user.temporary_password
  
            if user.save
              SendWelcomeEmailJob.perform_later(user.id)
            else
              # Log the error but continue processing other rows
              Rails.logger.error("Failed to create user: #{user.errors.full_messages.join(', ')}")
            end
          end
          redirect_to admin_users_path, notice: "Users imported successfully. Emails are being sent to all users."
        rescue StandardError => e
          redirect_to admin_users_path, alert: "Error importing users: #{e.message}"
        end
      else
        redirect_to admin_users_path, alert: "Please upload a CSV file."
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
  
    def generate_temporary_password
      loop do
        password = SecureRandom.random_number(900000) + 100000 # Generates a 6-digit number
        break password.to_s unless User.exists?(temporary_password: password.to_s)
      end
    end
end