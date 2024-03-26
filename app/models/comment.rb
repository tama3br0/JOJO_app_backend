class Comment < ApplicationRecord
  belongs_to :post
  validates :content, presence: true # 空のコメントは投稿できないようにするバリデーション

end
