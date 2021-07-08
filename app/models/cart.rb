class Cart
  include Mongoid::Document
  include Mongoid::Timestamps



  field :items, type: Array, default: []
  belongs_to :user
end
