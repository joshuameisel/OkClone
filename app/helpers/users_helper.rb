module UsersHelper
  def search_text
    {show_me: ["Girls", "Guys", "Guys and girls"]}
  end

  def show_me(num)
    if params[:search]
      params[:search][:show_me].to_i == num
    else
      current_user.show_me_value == num
    end
  end
end
