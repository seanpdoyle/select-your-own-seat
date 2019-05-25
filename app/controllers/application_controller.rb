class ApplicationController < ActionController::Base
  before_action do
    cart_token = cookies[:cart_token]

    Current.cart ||= Cart.create_or_find_by(token: cart_token)

    cookies[:cart_token] ||= Current.cart.token
  end
end
