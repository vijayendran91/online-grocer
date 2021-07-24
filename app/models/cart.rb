class Cart
  include Mongoid::Document
  include Mongoid::Timestamps


  field :items, type: Hash, default: {}
  field :cart_total_price, type: Float, default: 0.0
  field :each_item_price,type: Hash, default: {}
  belongs_to :order, :optional => true

end
