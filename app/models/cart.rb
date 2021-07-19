class Cart
  include Mongoid::Document
  include Mongoid::Timestamps



  field :items, type: Array, default: []
  field :c_t_pr, type: Float
  belongs_to :order
end
