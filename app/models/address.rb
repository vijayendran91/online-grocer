class Address
  include Mongoid::Document
  # validates :phone, :presence => true, :length => {:is => 10}
  # validates_uniqueness_of :phone
  belongs_to :user, :foreign_key => :user_id
  field :full_name, type: String
  field :addr_id, type: String
  field :contact_number, type: String
  field :street1, type: String
  field :street2, type: String
  field :area, type: String
  field :district, type: String
  field :state, type: String
  field :pin, type: String
  field :landmark, type: String

  before_save :addr_id_make

  def addr_id_make
    self.addr_id = self._id
    # TwoFactor.send_passcode
  end

end
