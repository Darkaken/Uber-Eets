class PublicController < ApplicationController
  helper_method :get_estado

  def homepage
    @msg = params[:msg]
    @users = Usuario.all
    @restaurantes = Restaurante.where(estado: 0)
  end

  def login_page
    if params[:msg] == "false"
      @msg = "Datos invalidos, intente de nuevo!"
    else
      @msg = ""
    end
    redirect_to "/di" #datos invalidos
  end

  def stats #INCOMPLETO
    @count_rest = 0
    @pedidos_por_rest = {}
    @ingresos_por_restaurante = {}

    Restaurante.where(estado: 0).each do |rest|
      @count_rest += 1
    end
  end

  def admin

    @count_rest = 0
    @pedidos_por_rest = {}
    @ingresos_por_restaurante = {}

    Restaurante.where(estado: 0).each do |rest|
      @count_rest += 1
    end

    @restaurantes = Restaurante.all.sort_by {|obj| obj.nombre}
    if admin_params.nil?
    else
      if admin_params.nil?
      else
        admin_params.each do |id, valor|
          if valor == "3"
            Restaurante.delete(id)
          else
            rest = Restaurante.find(Integer(id))
            rest.update(estado: valor)
          end
        end
      end
      redirect_back(fallback_location: "/users/admin")
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
      @msg = ''
      if params[:tipo]== "0"
        usuario = Usuario.where(nombre: params[:datos][:nombre], password: params[:datos][:password])
        # El elemento 0 es el objeto usuario en cuestion
        if usuario[0].nil?
          redirect_to "/login/false"
        else
          if usuario[0].tipo == 1
            redirect_to "/users/admin"
          else
            redirect_to :controller => "usuarios", :action => "dashboard", :data => usuario[0].id, :msg => "a"
          end
        end
      else
        restaurante = Restaurante.where(nombre: params[:datos][:nombre], password: params[:datos][:password])
        if restaurante[0].nil?
          redirect_to "/login/false"
        else
          redirect_to :controller => "restaurantes", :action => "dashboard", :id => restaurante[0].id
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

      redirect_to "/es"
    end
  end

  def dashboard
    @restaurantes = Restaurante.all
  end

  def view_restaurant
    @restaurante = Restaurante.find(params[:id])
    @platos = Plato.where(restaurante_id: @restaurante.id)
    @comentarios_rest = ComentarioRestaurante.where(restaurante_id: @restaurante.id)

    @puntaje = "N/A"
    if @comentarios_rest.nil? == false
      count = 0
      puntaje_acumulado = 0

      @comentarios_rest.each do |comentario|
        count += 1
        puntaje_acumulado += comentario.puntaje
      end

      if count != 0
        @puntaje = (puntaje_acumulado/count).round(1)
      end
    end
  end

  private

  def admin_params
    begin
      params.require(:datos)
    rescue Exception => e
      nil
    end
  end

  def user_params
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

end
