class Post < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_rich_text :content
end
