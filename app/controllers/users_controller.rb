class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => [:show]

  def index
    respond_to :html, :json, :js
    if current_user.admin?
      @users = User.where("parent=? or id=?", current_user.id, current_user.id).all
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to root_path, :alert => "Acesso NEGADO!"
      end
    end
  end

  def new
    if current_user.admin?
      @user = User.new(role: User.roles[:operator], parent: current_user.id)
      respond_to do |format|
        format.html
        format.js
      end
    else

    end
  end

  def create
    @user = User.new(secure_params)
    @user.confirmed_at = DateTime.now()
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: 'Atendente criado com sucesso!' }
        format.js { flash.now[:notice] = 'Atendente criado com sucesso!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params) && current_user.admin?
      redirect_to users_path, :notice => "Usuário atualizado com sucesso!"
    else
      redirect_to users_path, :alert => "Este usuário não tem permissão de alterar dados"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "Usuário excluído do sistema."
  end

  private

  def secure_params
    params.require(:user).permit(:parent, :role, :name, :email, :password, :mobile, :cpf, :password_confirmation)
  end

end
