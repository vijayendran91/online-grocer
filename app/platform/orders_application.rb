module OrdersApplication

  def get_items_from_cart(cart)
    item_ids = cart.items
    temp = []
    item_ids.each do |item, quantity|
      temp.push(item)
    end
    items = Item.where(:itm_id => { '$in': temp })
    return items
  end


  def get_total_price(items, item_qt)
    total_price = 0.0
    items.each do |item|
      total_price = total_price + (item[:itm_price] * item_qt[item[:itm_id]])
    end
    total_price
  end

  def add_item_to_cart(user, params)
    response = {:error => "Something went wrong"}
    if user.current_order.nil?
      order = create_order(user)
      user.orders[0] = order
      cart = Cart.new(:order_id => order[:order_id])
      cart = add_new_item_in_cart(nil, params[:item_id], cart)
      update_order_price_from_cart(cart, order)
    else
      current_order = nil
      user.orders.each do |order|
        if user.current_order.to_s == order[:order_id].to_s
          current_order = order
        end
      end
      if(current_order[:order_status]==Order::ORDER_CREATED.to_s)
        cart = current_order.cart
        item = Item.find_by(:itm_id => params[:item_id])
        if cart[:items].has_key?(params[:item_id].to_sym)
          add_existing_item_to_cart(item, cart)
          update_order_price_from_cart(cart, current_order)
          response = {:status => 200, :message => "#{item[:itm_name]} added to cart"}
        else
          add_new_item_in_cart(item, nil, cart)
          update_order_price_from_cart(cart, current_order)
          response = {:status => 200, :message => "#{item[:itm_name]} added to cart"}
        end
      end
    end
    response
  end


  def create_order(user)
    new_order = Order.new(:user_id => user[:user_id], :order_status => Order::ORDER_CREATED)
    user.orders.push(new_order)
    user.current_order = new_order[:order_id]
    new_order.save
    user.save
    new_order
  end

  def update_order_price_from_cart(cart, order)
    order.update(:total_price => cart.cart_total_price)
  end

  def include_total_price_in_cart(item, cart)
    current_price = cart.cart_total_price
    current_price += item[:itm_price]
    current_price
  end

  def add_new_item_in_cart(item, item_id, cart)
    if item.nil? && item_id
      item = Item.find_by(:itm_id => item_id)
    else
      item_id = item[:itm_id]
    end
    cart.cart_total_price = include_total_price_in_cart(item, cart)
    cart.each_item_price[item_id] = item[:itm_price]
    cart.items[item_id] = 1
    cart.save
    cart
  end

  def add_existing_item_to_cart(item, cart)
    item_id = item[:itm_id]
    if cart.items.has_key?(item_id) && cart.each_item_price.has_key?(item_id)
      cart.items[item_id] += 1
      cart.cart_total_price = include_total_price_in_cart(item,cart)
      cart.each_item_price[item_id] += item[:itm_price]
      cart.save
    end
  end

  def remove_item_from_cart(user, item_id)
    response = {:error => "Something went wrong"}
    unless user.current_order.nil?
      current_order = get_current_order(user)
      item = Item.find_by(:itm_id => item_id)
      if(current_order[:order_status]==Order::ORDER_CREATED.to_s)
        cart = current_order.cart
        if cart.items.has_key?(item_id)
          if cart.items[item_id] == 1
            remove_last_element_from_cart(item, cart)
            update_order_price_from_cart(cart, current_order)
            response = {:status => 200, :message => "#{item[:itm_name]} removed from cart."}
          else
            remove_existing_item_from_cart(item, cart)
            update_order_price_from_cart(cart, current_order)
            response = {:status => 200, :message => "#{item[:itm_name]} reduced by 1 count"}
          end
        else
          response = {:error => "#{item[:itm_name]} not in cart"}
        end
      end
    end
    response
  end

  def remove_existing_item_from_cart(item, cart)
    cart.items[item[:itm_id]] -= 1
    cart.each_item_price[item[:itm_id]] -= item[:itm_price]
    cart[:cart_total_price] -=  item[:itm_price]
    cart.save
  end

  def remove_last_element_from_cart(item, cart)
    cart.items = cart.items.except(item[:itm_id])
    cart.each_item_price = cart.each_item_price.except(item[:itm_id])
    cart[:cart_total_price] -=  item[:itm_price]
    cart.save
  end

  def get_current_order(user)
    current_order_id = user.current_order
    temp =  nil
    current_order = nil
    if !current_order_id.nil?
      temp = Order.find_by(:order_id => current_order_id)
    end
    current_order= temp if (temp && temp[:order_status]==Order::ORDER_CREATED.to_s)
    current_order
  end

  def change_order_status(order, status)
    if(order[:order_status]==Order::ORDER_CREATED.to_s)
      order.user.update(:current_order => nil)
    end
    order.update(:order_status => status)
  end
end
