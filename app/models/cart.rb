class Cart
  include Mongoid::Document
  include Mongoid::Timestamps



  field :items, type: Hash, default: {}
  belongs_to :user
end
