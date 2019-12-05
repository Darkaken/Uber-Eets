class RestaurantesController < ApplicationController

  def dashboard
    @restaurante = Restaurante.where(id: params[:data])[0]

    if @restaurante.estado == 1
      render "solicitud_pendiente.html.erb"
    elsif @restaurante.estado == 2
      render "solicitud_rechazada.html.erb"
    else
      cargar_datos()
      puts 'login successful'
    end
  end

  def cargar_datos
    @platos = Plato.where(restaurante_id: @restaurante.id)

    @ordenes = []
    @comentarios_platos = []
    @platos.each do |plato|

      ContienePlato.all.each do |contiene_plato|
        if contiene_plato.plato_id == plato.id
          @ordens += Orden.where(id: contiene_plato.orden_id)
        end
      end

      ComentarioPlato.all.each do |comentario_plato|
        if comentario_plato.plato_id == plato.id
          @comentario_platos += [comentario_plato]
        end
      end
    end
    @comentarios_rest = ComentarioRestaurante.where(restaurante_id: @restaurante.id)
  end

  def crear_plato
    @restaurante = Restaurante.find(params[:id])
    if params[:datos].nil? == true # GET Method (if no data)
    else                           # POST Method
      plato = Plato.new(params_crear_plato)
      plato.restaurante_id = @restaurante.id.dup
      plato.save
    end
  end

  def detalles_plato
    @plato = Plato.find(params[:id_plato])
    @id_rest = params[:id_rest]
  end

  def params_crear_plato
    params.require(:datos).permit(:nombre, :precio, :descripcion, :porciones, :image)
  end

end
