class User < ApplicationRecord
    has_many :posts , foreign_key: 'author'
    validates :name, presence: { message: "Username can't be blank" }
  validates :email, presence: { message: "Email can't be blank" }, uniqueness: { message: "Email has already been taken" }
  validates :password, presence: { message: "Password can't be blank" }
end
