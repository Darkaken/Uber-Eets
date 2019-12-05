Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Homepage
  root to: "public#homepage"
  get "/dashboard" => "public#dashboard"

  #Get login and enter login data
  get "/login" => "public#login_page"
  post "/login" => "public#login_user"

  #Get signup and enter register data
  get "/signup" => "public#signup"
  post "/signup" => "public#signup"
  get "/exitosignup" => "public#exitosignup"

  get "/userdashboard/:data" => "usuarios#dashboard"
  get "/restaurantdashboard/:data" => "restaurantes#dashboard"

end
