class Post < ApplicationRecord
    has_many :comments
    validates :img ,:author ,  presence: true
end
