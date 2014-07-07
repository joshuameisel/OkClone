module UsersHelper
  def search_text
    {
      show_me: ["Girls", "Guys", "Guys and girls"],
      who_like: ["girls", "guys", "either"]
    }
  end

  def show_me(num)
    if params[:search]
      params[:search][:show_me].to_i == num
    else
      current_user.show_me_value == num
    end
  end

  def who_like(num)
    if params[:search]
      params[:search][:who_like].to_i == num
    else
      User::GENDERS.invert[[current_user.gender]] == num
    end
  end
end
