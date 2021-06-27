class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update destroy ]

  # GET /users or /users.json
  def home
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = current_user()
    @addresses = Address.where(:user_id => @user[:user_id]).all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by(:user_id => params[:id])
    response = TwoFactor.send_passcode(@user[:phone])
    @user.update({:otp_session => response["Details"]})
    sign_up_data = {:phone => @user[:phone],
                    :action => "edit_user"
                   }
    redirect_to user_verify_otp_path(:sign_up_data => sign_up_data)
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    response = TwoFactor.send_passcode(params[:phone])
    @user[:otp_session] = response["Details"]
    respond_to do |format|
      if @user.save
        sign_up_data = {:phone => @user[:phone],
                        :action => "sign_up"
                       }
        format.html { redirect_to user_verify_otp_path(:sign_up_data => sign_up_data), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def account_settings
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:phone, :fname, :lname, :password)
    end
end
