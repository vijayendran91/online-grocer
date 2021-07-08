class OrdersController < ApplicationController
  def add_to_cart
    user = current_user
    response = {}
    if user.nil?
      response = {:error => "Please Log in to add/remove items to cart", :redirect_url => '/user/login'}
    elsif !user.nil?
      if user.cart.nil?
        user.cart = Cart.new(:items => {params[:item_id] => 1})
        user.cart.save
        response = {:status => 200}
      else
        items = user.cart.items
        if items.key?(params[:item_id])
          user.cart.items[params[:item_id]] = user.cart.items[params[:item_id]] + 1
          user.cart.save
        else
          user.cart.items[params[:item_id]] = 1
          user.cart.save
        end
        response = {:status => 200}
      end
    end
    render :json=> response
  end

  def remove_from_cart
    user = current_user
    response = {}
    if user.nil?
      binding.pry
      response = {:error => "Please Log in to add/remove items to cart", :redirect_url => '/user/login'}
    else !user.nil?
      binding.pry
      if user.cart.nil?
        binding.pry
        response = {:status => 200}
      else
        items = user.cart.items
        if items.key?(params[:item_id])
          binding.pry
          if (user.cart.items[params[:item_id]] != 0)
            user.cart.items[params[:item_id]] = user.cart.items[params[:item_id]] - 1 if (user.cart.items[params[:item_id]] != 0)
            user.cart.save
          end
          response = {:status => 200}
        else
          binding.pry
          response = {:status => 200}
        end
      end
    end
    render :json=> response
  end
end
