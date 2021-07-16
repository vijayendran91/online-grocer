class OrdersController < ApplicationController
  require_relative '../platform/orders_application'
  require_relative '../platform/razorpay_application'
  include OrdersApplication
  include RazorpayApplication
  skip_before_action :verify_authenticity_token, :only => :order_confirmation
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
      response = {:error => "Please Log in to add/remove items to cart", :redirect_url => '/user/login'}
    else !user.nil?
      if user.cart.nil?
        response = {:status => 200}
      else
        items = user.cart.items
        if items.key?(params[:item_id])
          if (user.cart.items[params[:item_id]] != 0)
            user.cart.items[params[:item_id]] = user.cart.items[params[:item_id]] - 1 if (user.cart.items[params[:item_id]] != 0)
            user.cart.save
          end
          response = {:status => 200}
        else
          response = {:status => 200}
        end
      end
    end
    render :json=> response
  end

  def cart
    user = current_user
    @item_ids = user.cart.items
    @items = get_items_from_cart(user.cart)
  end

  def icart
    user = current_user
    @item_ids = user.cart.items
    @items = get_items_from_cart(user.cart)
    render :partial => 'cart_table', :layout => false
  end

  def checkout
    user = current_user
    cart = user.cart
    @item_ids = user.cart.items
    @items = get_items_from_cart(user.cart)
    razor = RazorpayGateway.new
    order = submit_order(@items,@item_ids, user)
    rp_order = razor.create_rp_order(order[:total_price], "TEST")
    rp_order = rp_order.attributes
    @options = razor.create_options(rp_order, order)
  end
end
