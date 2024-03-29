class Api::AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    Rails.logger.debug("Received login request for email: #{params[:email]}")

    # ユーザーが存在し、かつパスワードが正しい時
    if user && user.authenticate(params[:password])
        token = generate_jwt_token(user)
        render json: { token: token }
    else
        render json: { error: 'Invalid email or passeord' }, status: :unprocessable_entity
    end
  end

# トークンのデコード結果は、ユーザーIDを含むペイロードと署名アルゴリズムを示す情報のペアで構成されている
# ユーザーIDにアクセスするためには配列の最初の要素からユーザーIDを取得する必要があり

  def logout
    token = extract_token_from_header
    decoded_token = decode_token(token)
    # decoded_tokenが存在しているかどうかを確認 = nilじゃなかったらtrue
    # decoded_tokenの最初の要素がハッシュであるかを確認
    # デコードされたトークンはペイロードと署名のペアで構成されている.
    # ペイロードがハッシュであるため、この条件が成立することが期待
    user_id = decoded_token.first['user_id'] if decoded_token.present? && decoded_token.first.is_a?(Hash)
    # decoded_tokenが存在し、かつ最初の要素がハッシュのときにこの行は実行される
    # その場合、ユーザーIDがペイロード内のキー[use_id]に代入される.デコードされたトークンからユーザーID取得
    head :no_content
  end
end
