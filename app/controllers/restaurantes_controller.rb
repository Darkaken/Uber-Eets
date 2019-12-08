class RestaurantesController < ApplicationController

  def dashboard
    @restaurante = Restaurante.where(id: params[:id])[0]
    if @restaurante.estado == 1
      render "solicitud_pendiente.html.erb"
    elsif @restaurante.estado == 2
      render "solicitud_rechazada.html.erb"
    else
      cargar_datos()
      puts 'login successful'
    end
  end

  def perfil
    @success = false
    @restaurante = Restaurante.find(params[:id])
    if params[:datos].nil? == false

      update_data = params_update_perfil.dup
      update_data.each do |key, value|
        print key, value
        if value == '' or value == ' '
          update_data.delete(key)
        end
      end

      @restaurante.update(update_data)
      @success = true
    end
  end

  def cargar_datos
    @platos = Plato.where(restaurante_id: @restaurante.id)

    @ordenes = []
    @comentarios_platos = []
    @platos.each do |plato|

      ContienePlato.all.each do |contiene_plato|
        if contiene_plato.plato_id == plato.id

          @ordenes += Orden.where(id: contiene_plato.orden_id)
        end
      end
    end
    @comentarios_rest = ComentarioRestaurante.where(restaurante_id: @restaurante.id)
  end

  def crear_plato
    @msg = ''
    @restaurante = Restaurante.find(params[:id])
    if params[:datos].nil? == true # GET Method (if no data)
    else                           # POST Method
      @msg = "Plato creado!"
      plato = Plato.new(params_crear_plato)
      plato.restaurante_id = @restaurante.id.dup
      plato.save
    end
  end

  def eliminar_plato
    puts params
    id = params[:id_plato]
    puts id
    Plato.delete(id)
    redirect_to "/restaurantdashboard/#{params[:id_rest]}"
  end

  def detalles_plato
    @id_rest = params[:id_rest]
    @plato = Plato.find(params[:id])
  end

  def params_crear_plato
    params.require(:datos).permit(:nombre, :precio, :descripcion, :porciones, :image)
  end

  def params_update_perfil
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

end
