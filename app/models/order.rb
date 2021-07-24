class Order
  include Mongoid::Document

  before_save :order_id_make

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
  field :order_status, type: String
  belongs_to :user
  has_one :cart


  def order_id_make
    self.order_id = self._id
  end

  ORDER_CREATED = :oc
  ORDER_PLACED = :op
  PAYMENT_INITIALIZED = :pi
  PAYMENT_FAILURE = :pf
  PAYMENT_SUCCESS = :ps
  PACKING_ORDER = :po
  OUT_FOR_DELIVERY = :ofd
  DELIVERED = :d
  COMPLETE = :c


  ORDER_STATUS={ORDER_CREATED => "Order Created",
                   ORDER_PLACED => "Order Placed",
                   PAYMENT_INITIALIZED => "Payment Initialized",
                   PAYMENT_FAILURE => "Payment Failure",
                   PAYMENT_SUCCESS => "Payment Success",
                   PACKING_ORDER => "Packing Order",
                   OUT_FOR_DELIVERY => "Out For Delivery",
                   DELIVERED => "Delivered",
                   COMPLETE => "Complete"
                  }
  ORDER_STATUS_LIST=["Order Created", "Order Placed","Payment Initialized","Payment Failure","Payment Success","Packing Order","Out For Delivery","Delivered","Complete"]
  ORDER_STATUS_REV = ORDER_STATUS.invert

end
