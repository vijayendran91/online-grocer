class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :phone, type: String
  field :fname, type: String
  field :lname, type: String
  field :password_digest, type: String
  has_secure_password

end
