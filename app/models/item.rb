class Item
  include Mongoid::Document

  field :item_id, type: String
  field :item_name, type: String
  field :item_wslae_cntct, type: String
  field :item_g_u, type: String
  field :item_price, type: Float
  field :item_quantity, type: Integer
  before_save :item_id_make
  def item_id_make
    self.item_id = self._id
  end

end
