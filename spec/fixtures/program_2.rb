class Customer

  attr_accessor :customer_id, :customer_name, :company_name
  attr_accessor :street_address_1, :street_address_2
  attr_accessor :city, :state, :postal_code, :phone_number

  MY_CONSTANT = "TheOtherZachIsThePrimaryZach"

  def self.api_root
    "http://localhost/api/"
  end

  def address_is_residence?
    self.company_name.nil?
  end

  def neighborhood
    NeighborhoodApi.post(
      state: self.state,
      city: self.city,
      postal_code: self.postal_code
    ).results[:neighborhood]
  end

  def verified_state
    NeighborhoodApi.post(
      city: self.city,
      postal_code: self.postal_code
    ).results[:state]
  end

  def verified_country
    NeighborhoodApi.post(
      state: self.state,
    ).results[:country]
  end

  def business_card_api_call
    {name: customer_name, business: company_name, phone: phone_number}
  end

  def letterhead_api_call
    {name: customer_name, business: company_name}
  end

  def letterhead
    "#{customer_name}\r#{company_name}"
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