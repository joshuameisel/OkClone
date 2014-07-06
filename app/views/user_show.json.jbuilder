json.(@user, :dob, )

render json: @user.to_json(methods: [:age, :profile, :likes, :profile_pic])