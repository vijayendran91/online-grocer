class Address
  include Mongoid::Document
  # validates :phone, :presence => true, :length => {:is => 10}
  # validates_uniqueness_of :phone
  before_save :addr_id_make

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
  field :cntct_phone, type: String
  field :addr_type, type: Array
  belongs_to :user


  def addr_id_make
    self.addr_id = self._id
    # TwoFactor.send_passcode
  end

  PERMANENT_ADDRESS = :pa
  BILLING_ADDRESS = :ba


end
