 require 'rails_helper'

RSpec.describe "Apartments", type: :request do
  let(:user) do
    User.create email: 'test@example.com', password: 'password', password_confirmation: 'password'
  end

  # -----index-----
  describe "GET /index" do
    it 'gets all the apartments' do
      user.apartments.create(
        street: '221c Baker Street', 
        city: 'London', 
        state: 'England', 
        manager: 'Ms. Hudson', 
        email: 'hudson@example.com', 
        price: '1000', 
        bedrooms: 2, 
        bathrooms: 2, 
        pets: 'yes'
      )

      get '/apartments'

      apartments = JSON.parse(response.body)
      expect(apartments.length).to eq 1
      expect(response).to have_http_status(200)

      apartment = apartments.first
      expect(apartment['street']).to eq '221c Baker Street'
      expect(apartment['city']).to eq 'London'
      expect(apartment['state']).to eq 'England'
      expect(apartment['manager']).to eq 'Ms. Hudson'
      expect(apartment['email']).to eq 'hudson@example.com'
    end
  end
end
