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
      response = add_item_to_cart(user, params)
    end
    render :json=> response
  end

  def remove_from_cart
    user = current_user
    response = {}
    if user.nil?
      response = {:error => "Please Log in to add/remove items to cart", :redirect_url => '/user/login'}
    else !user.nil?
      response = remove_item_from_cart(user, params[:item_id])
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
