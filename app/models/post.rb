class Post < ApplicationRecord
    mount_uploader :image, ImageUploader

    def image_url
        "uploads/images/#{image}"
    end

end
