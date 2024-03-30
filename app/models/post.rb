class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :user

    def image_url
        image.url if image.present?
    end

    has_many :comments, dependent: :destroy # 関連するコメントも削除する
end
