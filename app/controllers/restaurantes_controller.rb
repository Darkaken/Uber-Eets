class RestaurantesController < ApplicationController

  def dashboard
    @restaurante = Restaurante.where(id: params[:id])[0]
    if @restaurante.estado == 1
      render "solicitud_pendiente.html.erb"
    elsif @restaurante.estado == 2
      render "solicitud_rechazada.html.erb"
    else
      cargar_datos()
    end
  end

  def cambiar_img_rest
    @restaurante = Restaurante.find(params[:id])
    image = params.require(:restaurante).permit(:avatar)
    @restaurante.update(image)
    redirect_to "/restaurantprofile/#{@restaurante.id}"
  end

  def cambiar_img_plato
    @plato = Plato.find(params[:id])
    image = params.require(:plato).permit(:picture)
    @plato.update(image)
    @restaurante = Restaurante.find(params[:id_rest])
    redirect_to "/info_plato/#{@restaurante.id}/#{@plato.id}"
  end

  def orden
    @restaurante = Restaurante.find(params[:id])
    @orden = Orden.find(params[:id_orden])

    @contiene_platos = ContienePlato.where(orden_id: @orden.id)
    @platos = []
    @contiene_platos.each do |cont_plato|
      if cont_plato.cantidad != 0 and cont_plato.cantidad != "0"
        print 'heey'
        print cont_plato.cantidad
        print 'heey x2'
        @platos.push([Plato.find(cont_plato.plato_id), cont_plato.cantidad])
      end
    end

    if params[:respuesta].nil? == false
      respuesta = params[:respuesta]

      if respuesta == "Aceptar orden"
        @orden.estado = true
        @orden.save
      else
        @orden.delete()
      end
      redirect_to "/restaurantdashboard/#{@restaurante.id}"
    end
  end

  def perfil
    @success = false
    @restaurante = Restaurante.find(params[:id])
    if params[:datos].nil? == false

      update_data = params_update_perfil.dup
      update_data.each do |key, value|
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
    @ordenes = @ordenes.uniq
    end
    @comentarios_rest = ComentarioRestaurante.where(restaurante_id: @restaurante.id)
  end

  def crear_plato
    @plato = Plato.new()
    @msg = ''
    @restaurante = Restaurante.find(params[:id])
    if params[:datos].nil? == true # GET Method (if no data)
    else                           # POST Method
      @msg = "Plato creado!"
      @plato.update(params_crear_plato)
      @plato.restaurante_id = @restaurante.id.dup
      @plato.save
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
    @restaurante = Restaurante.find(@id_rest)
  end

  def params_crear_plato
    params.require(:datos).permit(:nombre, :precio, :descripcion, :porciones)
  end

  def params_update_perfil
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

end
