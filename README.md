# Apartment App Stub
This app has been created for you to mimic the feeling of entering into a developer role where there is established code that you have not written or installed. This Apartment app has a few features that have been created for you and some key items that have been left totally untouched. Part of your job as a developer is to be able to pick up code that has already been created; understand what is going on with it; and continue the development of that code. 

# Commands that have ben run
```
$ rails new apartment-app -d postgresql -T
$ cd apartment-app
$ rails db:create
$ bundle add rspec-rails
$ rails generate rspec:install
$ bundle add webpacker
$ bundle add react-rails
$ rails webpacker:install
$ rails webpacker:install:react
$ yarn add @babel/preset-react
$ yarn add @rails/activestorage
$ yarn add @rails/ujs
$ rails generate react:install
$ rails generate react:component App
$ bundle add devise
$ rails generate devise:install
$ rails generate devise User
$ rails db:migrate
$ rails generate controller Home
```

# Code that has been added
**config/environments/development.rb**
`config.action_mailer.default_url_options = { host: 'localhost', port: 3000 } `

**config/initializers/devise.rb**
``` ruby
# Find this line:
config.sign_out_via = :delete
# And replace it with this:
config.sign_out_via = :get
```
Add a file in app/views/home called index.html.erb
**app/views/home/index.html.erb**
```javascript
<%= react_component 'App', {
  logged_in: user_signed_in?,
  current_user: current_user,
  new_user_route: new_user_registration_path,
  sign_in_route: new_user_session_path,
  sign_out_route: destroy_user_session_path
} %>
```

**app/views/layouts/application.html.erb**
```ruby
// Find this line:
<%= javascript_importmap_tags %>

// And replace it with this:
<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```
**config/routes.rb**
```ruby
get '*path', to: 'home#index', constraints: ->(request){ request.format.html? }
root 'home#index'
```
### React Routing
- $ `yarn add react-router-dom@5.3.0`

**app/javascript/components/App.js**
```javascript
import {
  BrowserRouter as  Router,
  Route,
  Switch
} from 'react-router-dom'
```

### Adding Reactstrap
- $ `bundle add bootstrap`
- $ `mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss`
- $ `yarn add reactstrap`

**app/assets/stylesheets/application.scss**
```css
@import 'bootstrap';
```


# What needs to happen next
- clone down the app 
```
$ bundle 
$ yarn
$ rails db:setup
```
- Run the app 
` $ rails s`
- See what is available in the app  
  - What can a USER do? 
  - What views (pages, components) are available? 
  - What tests are available to run? 
    - `$ yarn jest` to run the test

### Apartment Resource
The Devise User model is going to have an association with the Apartment model. In this situation, the User will have many apartments and the Apartments will belong to a User.

- $ `rails g resource Apartment street:string city:string state:string manager:string email:string price:string bedrooms:integer bathrooms:integer pets:string image:text user_id:integer`
- $ `rails db:migrate`

### User and Apartment Associations
The Apartments will belong to a User and a User will have many apartments.

**app/models/apartment.rb**
```ruby
class Apartment < ApplicationRecord
  belongs_to :user
end
```

**app/models/user.rb**
```ruby
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :apartments
end
```

### Apartment RSpec tests 
Part of your responsibility will be to build out robust tests both for models and for requests. 
Tests you will need are: 
REQUEST: 
  - for many apartments
  - for a single apartment
  - for authorized apartments
  - to make a new apartment
  - for error when when you make a new an apartment without every field
  - for error when you try to make an apartment without being logged in
  - to take an existing apartment and change its values
  - for error when you try to edit an apartment that doesn't belong to you
  - to get rid of an apartment from the database
  - for error when you try to to get rid of an apartment that doesn't belong to you

MODELS: 
  - for many apartments
  - for a single apartment
  - for authorized apartments
  - to make a new apartment
  - for error when when you make a new an apartment without every field
  - for error when when you make a new an apartment that already exists in the database
  - for error when you try to make an apartment without a user being associated with it 
  - to take an existing apartment and change its values
  - for error when you try to edit an apartment that doesn't belong to you
  - to get rid of an apartment from the database
  - for error when you try to to get rid of an apartment that doesn't belong to you


**The following code will not work but is here to get your started**
```ruby
require 'rails_helper'

RSpec.describe "Apartments", type: :request do
  describe "GET /index" do
    it "gets a list of apartments " do
    
      user = User.where(email: 'test@test.test').first_or_create?(password: '12345678', password_confirmation: '12345678')

      user.create_apartment!(
        street: string,
        city:string,
        state:string,
        manager:string,
        email:string, 
        price:string, 
        bedrooms:integer, 
        bathrooms:integer, 
        pets:string,
        image:text, 
        user_id:integer
      )

      # Make a request
      get '/apartments'

      apartments = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(apartment.length).to eq 1
    end
  end
end