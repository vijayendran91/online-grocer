class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  validates :phone, :presence => true, :length => {:is => 10}
  validates_uniqueness_of :phone

  field :phone, type: String
  field :user_id, type: String
  field :fname, type: String
  field :lname, type: String
  field :password_digest, type: String

  has_secure_password

  def user_id_make
    self.user_id = self._id
    TwoFactor.send_passcode
    binding.pry
  end
end
