# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# サンプルユーザーの作成
User.create!(
    name: 'Jonathan Joestar',
    email: 'jonathan@joestar.com',
    password: 'password',
    icon: 'https://jojo-portal.com/special/digital-contents/assets/images/common/icon_golden-wind.png'
)

User.create!(
    name: 'Joseph Joestar',
    email: 'joseph@joestar.com',
    password: 'password',
)

# 他のサンプルデータを追加する場合はここに追加してください

User.create(
    name: 'Jo',
    email: 'jo@example.com',
    password: 'password',
    icon: 'https://jojo-portal.com/special/digital-contents/assets/images/common/icon_golden-wind.png'
)