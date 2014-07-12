class Customer

  attr_accessor :customer_id, :customer_name, :company_name
  attr_accessor :street_address_1, :street_address_2
  attr_accessor :city, :state, :postal_code

  def address_is_residence?
    self.company_name.nil?
  end

  def get_coords_for_address
    fake_api_call(city: city, state: state, postal_code: postal_code)
  end

  def neighborhood
    fake_neighborhood_api_call(state: self.state, city: self.city, postal_code: self.postal_code)
  end

  def something_else
    fake_neighborhood_api_call(city: self.city, state: self.state)
  end

  def and_something_else_again
    fake_neighborhood_api_call(city: self.city)
  end

  def and_something_else_again_and_again
    fake_neighborhood_api_call(state: self.state)
  end

  def fake_neighborhood_api_call(args={})
    "Probably River North"
  end

  def fake_api_call(args={})
    [112.32, 124.11]
  end

  def business_card_api_call
    {name: customer_name, business: company_name}
  end

  def letterhead_api_call
    {name: customer_name, business: company_name}
  end

  def address
    string = ""
    string << self.customer_name
    string << self.company_name if address_is_residence?
    string << self.street_address_1
    string << self.street_address_2 if street_address_2.present?
    string << "#{self.city}, #{self.state} #{self.postal_code}"
    string.join", "
  end

end