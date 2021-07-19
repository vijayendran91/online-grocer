class Order
  include Mongoid::Document

  field :order_id, type: String
  field :buyer_id, type: String
  field :total_price, type: Float
  field :disnt, type: Float
  field :final_price,type: Float
  field :gst,type: Float
  field :sgst, type: Float
  field :amnt_discnt, type: Float
  field :dlvry_addr, type: String
  field :dlvry_agnt,type: String
  field :cart_id, type: String
  belongs_to :user
  has_one :cart
end
