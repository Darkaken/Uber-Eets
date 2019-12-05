class PublicController < ApplicationController

  def homepage
    @users = Usuario.all
  end

  def login_page
  end

  def login_user
      if params[:tipo]== "0"
        usuario = Usuario.where(nombre: params[:datos][:nombre], password: params[:datos][:password])
        # El elemento 0 es el objeto usuario en cuestion
        if usuario[0].nil?
          redirect_to "/login"
        else
          redirect_to :controller => "usuarios", :action => "dashboard", :data => usuario[0].id
        end

      else
        restaurante = Restaurante.where(nombre: params[:datos][:nombre], password: params[:datos][:password])
        if restaurante[0].nil?
          redirect_to "/login"
        else
          redirect_to :controller => "restaurantes", :action => "dashboard", :data => restaurante[0].id
        end
      end
  end

  def signup

    if params == {"controller"=>"public", "action"=>"signup"}
    else
      if params[:tipo]== "0"
        usuario = Usuario.new(user_params)
        usuario.save
      else
        # Pendiente = 1
        # Aceptado = 0
        # Rechazado = 2

        data = user_params.dup
        data['estado'] = 1
        restaurante = Restaurante.new(data)
        restaurante.save
      end

      redirect_to "/exitosignup"
    end
  end

  def dashboard
    @restaurantes = Restaurante.all
  end

  private

  def user_params
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

end
