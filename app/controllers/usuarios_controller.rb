class UsuariosController < ApplicationController

  def dashboard
    @usuario = Usuario.where(id: params[:data])[0]
    @restaurantes = Restaurante.where(estado: 0)

    @msg = ''
    if params[:msg].nil? == false
      @msg = params[:msg]
    end
  end

  def cambiar_img
    @usuario = Usuario.find(params[:data])
    image = params.require(:usuario).permit(:image)
    @usuario.update(image)

    redirect_to "/userdashboard/#{@usuario.id}/perfil"
  end

  def perfil
    @success = false
    @usuario = Usuario.find(params[:data])
    @restaurantes = Restaurante.where(estado: 0)

    rest_fav_table = RestFav.where(usuario_id: @usuario.id)[0]

    if rest_fav_table.nil? == false
      @restaurante_fav = Restaurante.find(rest_fav_table.restaurante_id)
    end

    if params[:datos].nil? == false

      update_data = params_update_perfil.dup
      update_data.each do |key, value|
        if value == '' or value == ' '
          update_data.delete(key)
        end
      end

      fav_id = params[:fav]

      if fav_id != 'nil'

        if rest_fav_table.nil? == false
          RestFav.delete(rest_fav_table.id)
        end
        RestFav.create(usuario_id: @usuario.id, restaurante_id: fav_id)
        redirect_back(fallback_location: "/userdashboard/#{@usuario.id}/perfil")

      end
      @usuario.update(update_data)
      @success = true
    end
  end

  def view_restaurant
    @restaurante = Restaurante.find(params[:id])
    @usuario = Usuario.find(params[:data])
    @platos = Plato.where(restaurante_id: @restaurante.id)
    @comentarios_rest = ComentarioRestaurante.where(restaurante_id: @restaurante.id)

    if params[:del_id].nil? == false
      coment = ComentarioRestaurante.find(params[:del_id])
      coment.delete()
    end

    if params[:comentario].nil? == false
      ComentarioRestaurante.create(params_comentario)
    end

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

  def self.get_user_from_id(id)
    Usuario.find(id)
  end

  def ordenes
    id = params[:data]
    @id = id
    @ordenes_pasadas = Orden.where(usuario_id: id, estado: true)
    @ordenes_pendientes = Orden.where(usuario_id: id, estado: false)
  end

  def self.find_rest_by_order_id(orden_id)
    plato_id = ContienePlato.where(orden_id: orden_id)[0].plato_id
    Restaurante.find(Plato.find(plato_id).restaurante_id)
  end

  def self.get_medio_de_pago(id_medio_pago)
    if id_medio_pago == 1
      "Efectivo"
    elsif id_medio_pago == 2
      "Crédito"
    elsif id_medio_pago == 3
      "Débito"
    else
      "EetsPay"
    end
  end

  def pedido
    @usuario = Usuario.find(params[:data])
    @restaurante = Restaurante.find(params[:id])
    @platos = Plato.where(restaurante_id: @restaurante.id)

    if params[:datos].nil? == false
      @orden = Orden.new(usuario_id: @usuario.id, estado: 0)
      @orden.update(params_pedido)
      @orden.save

      params[:datos].each do |id_plate, quant|
        if quant != 0
          contiene_plato = ContienePlato.create(orden_id: @orden.id, plato_id: id_plate, cantidad: quant)
        end
      end

      redirect_to action: 'dashboard', msg: "Pedido Ingresado!"
    end
  end

  def detalle_orden
    @usuario = Usuario.find(params[:data])
    @orden = Orden.find(params[:orden_id])

    @contiene_platos = ContienePlato.where(orden_id: @orden.id)
    @restaurante = Restaurante.find(Plato.find(@contiene_platos[0].plato_id).restaurante_id)
    @platos = []
    @contiene_platos.each do |cont_plato|
      @platos.push([Plato.find(cont_plato.plato_id), cont_plato.cantidad])
    end
  end

  def confirmacion_pedido
    @usuario = Usuario.find(params[:data])
    @restaurante = Restaurante.find(params[:id])
    @platos = Plato.where(restaurante_id: @restaurante.id)

    @datos = params[:datos]
    datos2 = @datos.dup
    @total = 0

    datos2.each do |key, value|
      if value == 0
        @datos.delete(key)
      end
    end

    @datos.each do |key, value|
      puts @total
      @total += (value.to_i * Plato.where(id: key)[0].precio.to_i)
    end
  end

  def params_update_perfil
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

  def params_pedido
    params.require(:carrito).permit(:direccion_entrega, :medio_pago, :notas, :precio)
  end

  def params_comentario
    params.require(:comentario).permit(:usuario_id, :restaurante_id, :fecha, :puntaje, :contenido)
  end

end
