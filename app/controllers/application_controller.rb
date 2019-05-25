class ApplicationController < ActionController::Base
  before_action :ensure_cart_exists

  private

  def ensure_cart_exists
    cart_token = cookies[:cart_token]

    Current.cart ||= Cart.create_or_find_by(token: cart_token)

    cookies[:cart_token] ||= Current.cart.token
  end
end
