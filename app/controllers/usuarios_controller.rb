class UsuariosController < ApplicationController

  def dashboard
    @usuario = Usuario.where(id: params[:data])[0]
    @restaurantes = Restaurante.where(estado: 0)
  end

  def perfil
    @success = false
    @usuario = Usuario.find(params[:data])
    @restaurantes = Restaurante.where(estado: 0)

    rest_fav_table = RestFav.where(usuario_id: @usuario.id)[0]
    @restaurante_fav = Restaurante.find(rest_fav_table.restaurante_id)

    if params[:datos].nil? == false

      update_data = params_update_perfil.dup
      update_data.each do |key, value|
        if value == '' or value == ' '
          update_data.delete(key)
        end
      end

      fav_id = params[:fav]

      if fav_id != 'nil'

        RestFav.delete(rest_fav_table.id)
        RestFav.create(usuario_id: @usuario.id, restaurante_id: fav_id)
        redirect_back(fallback_location: "/userdashboard/#{@usuario.id}/perfil")

      end
      @usuario.update(update_data)
      @success = true
    end
  end

  def ordenes #INCOMPLETO
    id = params[:data]
    @ordenes_pasadas = Orden.where(usuario_id: id, estado: 1)
    @ordenes_pendientes = Orden.where(usuario_id: id, estado: 0)
  end

  def pedido
    @usuario = Usuario.find(params[:data])
    @restaurante = Restaurante.find(params[:id])
    @platos = Plato.where(restaurante_id: @restaurante.id)

    if params[:datos].nil? == false
      @orden = Orden.new(usuario_id: @usuario.id, estado: 1)
      @orden.update(params_pedido)
      puts @orden.medio_pago

      params[:datos].each do |id_plate, quant|
        contiene_plato = ContienePlato.create(orden_id: @orden.id, plato_id: id_plate, cantidad: quant)
      end
    end
  end

  def confirmacion_pedido
    @usuario = Usuario.find(params[:data])
    @restaurante = Restaurante.find(params[:id])
    @platos = Plato.where(restaurante_id: @restaurante.id)

    @datos = params[:datos]
    datos2 = datos.dup

    datos2.each do |key, value|
      if value == 0
        @datos.delete(key)
      end
    end
  end

  def params_update_perfil
    params.require(:datos).permit(:nombre, :correo, :direccion, :telefono, :password)
  end

  def params_pedido
    params.require(:carrito).permit(:direccion_entrega, :medio_pago, :notas)
  end

end
