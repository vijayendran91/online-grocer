class OrdersController < ApplicationController
  require_relative '../platform/orders_application'
  require_relative '../platform/razorpay_application'

  include OrdersApplication
  include RazorpayApplication

  skip_before_action :verify_authenticity_token, :only => :submit_order

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
    if logged_in?
      user = current_user
      current_order = get_current_order(user)
      cart = nil
      @img_size = '350x300'
      @item_ids = nil
      @item_total_price = nil
      @items = []
      if !current_order.nil? && !(current_order.cart).nil?
        cart = current_order.cart
        @img_size = '100x100'
        @item_ids = cart.items
        @item_total_price = cart.each_item_price
        @items = get_items_from_cart(cart)
      end
    else
      redirect_to user_login_path(:error => "Please log in to add items to cart")
    end
  end

  def icart
    user = current_user
    current_order = get_current_order(user)
    cart = nil
    if !(current_order.cart).nil?
      cart = current_order.cart
    end
    @img_size = '50x50'
    @item_ids = cart.items
    @item_total_price = cart.each_item_price
    @items = get_items_from_cart(cart)
    render :partial => 'cart_table', :layout => false
  end

  def checkout
    user = current_user
    @order = get_current_order(user)
    cart = @order.cart
    @item_ids = cart.items
    @items = get_items_from_cart(cart)
    razor = RazorpayGateway.new
    rp_order = razor.create_rp_order(@order[:total_price], "TEST")
    rp_order = rp_order.attributes
    @order.update(:rp_order_id => rp_order["id"])
    @options = razor.create_options(rp_order, @order)
  end

  def submit_order
    user = current_user
    order = get_current_order(user)
    razor = RazorpayGateway.new
    if razor.rp_signature_verified?(order, params)
      render :submit_order
    end
  end

end
