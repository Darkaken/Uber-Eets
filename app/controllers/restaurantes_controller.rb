class RestaurantesController < ApplicationController

  def dashboard
    @restaurante = Restaurante.where(id: params[:data])[0]

    if @restaurante.estado == 1
      render "solicitud_pendiente.html.erb"
    elsif @restaurante.estado == 2
      render "solicitud_rechazada.html.erb"
    else
      puts 'hey'
    end
  end
end
