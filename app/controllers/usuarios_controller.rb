class UsuariosController < ApplicationController

  def dashboard
    @usuario = Usuario.where(id: params[:data])[0]
    puts @usuario.nombre
  end

end
