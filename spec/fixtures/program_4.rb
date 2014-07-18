class LoadedAttrAccessor

  attr_accessor :name, :email, :password
  attr_accessor :city, :state, :postal_code

  def address
    {
      city: city,
      state: state,
      postal_code: postal_code
    }
  end

end