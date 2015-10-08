class User
  # name, email, phone, address

  def search
    @user = User.find_by_name('John')
  end

  def method_missing(name)
    name = name[6..-1]
    finder(name)
    if name == 'find_by_name'

    else name == 'find_by_email'

    end
  end
end