class Post < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader

    def image_url
        "uploads/images/#{image}"
    end

    has_many :comments, dependent: :destroy # 関連するコメントも削除する

end
