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

  def submit_order(items, item_qt_in_cart, buyer)
    order = Order.new()
    order[:buyer_id]=buyer[:user_id]
    order[:buyer_fname]= buyer[:fname]
    order.item = items
    order[:total_price] = get_total_price(items, item_qt_in_cart)
    order[:cart_id] = buyer.cart[:id].to_s
    return order
  end

  def get_total_price(items, item_qt)
    total_price = 0.0
    items.each do |item|
      total_price = total_price + (item[:itm_price] * item_qt[item[:itm_id]])
    end
    total_price
  end


end
