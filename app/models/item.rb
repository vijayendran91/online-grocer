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
  field :itm_ctg, type: String
  field :itm_qty, type: Integer
  field :itm_inv_qty, type: Integer
  before_save :itm_id_make
  def itm_id_make
    self.itm_id = self._id
  end


    ITEM_CATAGORIES={:pandr => "Pulses and Rice",
                     :bandd => "Breakfast and Dairy",
                     :sandm => "Spices and Masalas",
                     :fpands => "Foods Products and Snacks",
                     :handg => "Homecare and Goods"
                    }
    ITEM_CATAGORIES_LIST=["Pulses and Rice", "Breakfast and Dairy","Spices and Masalas","Foods Products and Snacks","Homecare and Goods"]
    ITEM_CATAGORIES_REV = ITEM_CATAGORIES.invert
    PULSE_AND_RICE = :pandr
    BREAKF_AND_DAIRY = :bandd
    SPICES_AND_MASALAS = :sandm
    FOODPRODS_AND_SNACKS = :fpands
    HOMECARE_AND_GOODS = :handg
    # ITEM_CATAGORIES=[PULSE_AND_RICE, BREAKF_AND_DAIRY, SPICES_AND_MASALAS ,FOODPRODS_AND_SNACKS, HOMECARE_AND_OGOODS]
end
