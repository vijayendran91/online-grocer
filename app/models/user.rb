class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  # validates :phone, :presence => true, :length => {:is => 10}
  # validates_uniqueness_of :phone

  field :phone, type: String
  field :user_id, type: String
  field :fname, type: String
  field :lname, type: String
  field :password_digest, type: String
  field :otp_session, type: String
  field :permission, type: Array, default: []
  field :current_order, type: String
  before_save :user_id_make
  has_secure_password
  has_many :orders
  has_many :addresses


  INVENTORY_MANAGER = 'm'
  DELIVERY_AGENT = 'd'
  CASHIER = 'c'
  ADMIN = 'a'
  USER_PERMISSIONS=[INVENTORY_MANAGER, DELIVERY_AGENT, CASHIER, ADMIN]


  def user_id_make
    self.user_id = self._id
    # TwoFactor.send_passcode
  end

end
