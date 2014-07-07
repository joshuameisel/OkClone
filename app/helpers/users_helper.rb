module UsersHelper
  def search_text
    {show_me: ["Girls", "Guys", "Guys and girls"]}
  end

  def show_me(num)
    params[:search] ? params[:search][:show_me].to_i == num : nil
  end
end
