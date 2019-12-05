class PublicController < ApplicationController
  helper_method :get_estado

  def homepage
    @users = Usuario.all
  end

  def login_page
  end

  def admin
    @restaurantes = Restaurante.all.sort_by {|obj| obj.nombre}
    if params == {"controller"=>"public", "action"=>"admin"}
    else
      if admin_params.nil?
      else
        admin_params.each do |id, valor|
          if valor == "3"
            puts id
            puts id.class
            Restaurante.delete(id)
            puts id
          else
            rest = Restaurante.find(Integer(id))
            rest.update(estado: valor)
          end
        end
      end
      redirect_back(fallback_location: "/admin")
    end
  end

  def get_estado(estado)
    if estado == 0
      'Aceptado'
    elsif estado == 1
      'Pendiente'
    else
      'Rechazado'
    end
  end

  def info_rest
    @restaurante = Restaurante.where(id: params[:id])[0]
  end

  def login_user
      if params[:tipo]== "0"
        usuario = Usuario.where(nombre: params[:datos][:nombre], password: params[:datos][:password])
        # El elemento 0 es el objeto usuario en cuestion
        if usuario[0].nil?
          redirect_to "/login"
        else
          if usuario[0].tipo == 1
            redirect_to "/admin"
          else
            redirect_to :controller => "usuarios", :action => "dashboard", :data => usuario[0].id
          end
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
        data = user_params.dup
        data['tipo'] = 0
        usuario = Usuario.new(data)
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

  def admin_params
    begin
      params.require(:data)
    rescue Exception => e
      nil
    end
  end

  def user_params
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

end
