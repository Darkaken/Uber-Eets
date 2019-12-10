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

  def cambiar_img_rest
    @restaurante = Restaurante.find(params[:id])
    image = params.require(:restaurante).permit(:avatar)
    @restaurante.update(image)
    redirect_to "/restaurantdashboard/#{@restaurante.id}"
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
    @platoss = []
    @contiene_platos.each do |cont_plato|
      if cont_plato.cantidad != 0 and cont_plato.cantidad != "0"
        print cont_plato.cantidad
        @platoss.push([Plato.find(cont_plato.plato_id), cont_plato.cantidad])
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

  def self.get_order(rest_id, order_id)
    @restaurante = Restaurante.find(rest_id)
    @orden = Orden.find(order_id)

    @contiene_platos = ContienePlato.where(orden_id: @orden.id)
    @platoss = []
    @contiene_platos.each do |cont_plato|
      if cont_plato.cantidad != 0 and cont_plato.cantidad != "0"
        @platoss.push([Plato.find(cont_plato.plato_id), cont_plato.cantidad])
      end
    end
    return @platoss
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

    redirect_to "/restaurantdashboard/#{@restaurante.id}#perfil"

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

    redirect_to "/restaurantdashboard/#{@restaurante.id}"

  end

  def eliminar_plato
    id_plato = params[:id_plato]
    Plato.delete(params[:id_plato])
    redirect_to "/restaurantdashboard/#{params[:id_rest]}"

    ContienePlato.all.each do |cont_plato|
      if cont_plato.plato_id == id_plato
        ord = Orden.find(orden_id)
        ord.delete()
      end
    end

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
