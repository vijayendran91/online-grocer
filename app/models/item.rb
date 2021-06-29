class Item
  include Mongoid::Document
  include Mongoid::Paperclip

  has_mongoid_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  field :itm_id, type: String
  field :itm_name, type: String
  field :itm_wslae_cntct, type: String
  field :itm_g_u, type: String
  field :itm_price, type: Float
  field :itm_qty, type: Integer
  field :itm_inv_qty, type: Integer
  before_save :itm_id_make
  def itm_id_make
    self.itm_id = self._id
  end

end
