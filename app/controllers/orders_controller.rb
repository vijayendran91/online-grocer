class OrdersController < ApplicationController
  def add_to_cart
    user = current_user
    response = {}
    if user.nil?
      response = {:error => "Please Log in to add items to cart", :redirect_url => '/user/login'}
    elsif !user.nil?
      if user.cart.nil?
        items = []
        items.push(params[:item_id])
        user_cart = Cart.new(:items => items)
        user.update(:cart => user_cart)
        response = {:status => 200}
      else
        items = user.cart.items
        items.push(params[:item_id])
        user.cart.update(:items => items)
        response = {:status => 200}
      end
    end
    render :json=> response
  end

  def remove_from_cart
    binding.pry
  end
end
