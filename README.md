# GitHub に写真をプッシュしないように、.gitignore に追記

/public/uploads # このディレクトリにあるものは github にプッシュしないように設定

# Gemfile

gem "dotenv-rails"　# MySQL のパスワードのベタ打ちを避けるための gem
gem "carrierwave" # 画像をアップロードするための gem
gem "mini_magick" #画像に対して処理を行う場合の gem

rails g model Post title:string image:string
rails db:migrate

rails g uploader image ← ここの名前は任意

```rb
class Post < ApplicationRecord
    mount_uploader :image, ImageUploader # モデルに追記

end
```

# コメントアウトを外す&追記

```rb
class ImageUploader < CarrierWave::Uploader::Base

    # Include RMagick or MiniMagick support:
    # include CarrierWave::RMagick
    include CarrierWave::MiniMagick

    # Choose what kind of storage to use for this uploader:
        storage :file
    # storage :fog

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:

        # 画像が保存されるディレクトリを指定します
        def store_dir
            'uploads/post/images'
        end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url(\*args)
    # # For Rails 3.1+ asset pipeline compatibility:
    # # ActionController::Base.helpers.asset*path("fallback/" + [version_name, "default.png"].compact.join('*'))
    # "/images/fallback/" + [version_name, "default.png"].compact.join('\_')
    # end
    # Process files as they are uploaded:
        process scale: [400, 400]

    # def scale(width, height)
    # # do something
    # end

    # Create different versions of your uploaded files:
    # version :thumb do
    # process resize_to_fit: [50, 50]
    # end

    # Add an allowlist of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_allowlist
        %w(jpg jpeg gif png)
    end
    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    # "something.jpg"
    # end

end
```

rails g controller Api::Posts

```rb
Rails.application.routes.draw do
    namespace :api do
        resources :posts, except: [:new, :edit]
    end
end
```
# jojo_app_back
# jojo_app_back
