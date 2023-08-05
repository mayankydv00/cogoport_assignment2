class Comment < ApplicationRecord
    belongs_to :post

    validates :post_id , :user_id , :text , presence: true

end
