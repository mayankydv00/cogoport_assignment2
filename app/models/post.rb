class Post < ApplicationRecord
    belongs_to :user , foreign_key:'author' 
    has_many :comments
    validates :img , :author ,  presence: true
end
