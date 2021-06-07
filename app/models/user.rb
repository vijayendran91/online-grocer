class User
  include Mongoid::Document
  field :phone, type: String
  field :fname, type: String
  field :lname, type: String
end
