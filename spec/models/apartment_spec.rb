require 'rails_helper'

RSpec.describe Apartment, type: :model do
  let(:user) { User.create email: 'sarah@test.com', password: '123456', password_confirmation: '123456' }

  it 'should have a valid street' do
    apartment = user.apartments.create(
      city: 'London', 
      state: 'England', 
      manager: 'Ms. Hudson', 
      email: 'mzhud@email.com', 
      price: '1000', 
      bedrooms: 2, 
      bathrooms: 2, 
      pets: 'no',
      image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg'
    )
    expect(apartment.errors[:street]).to include "can't be blank"
  end
end
