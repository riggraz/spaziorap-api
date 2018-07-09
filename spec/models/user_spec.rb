require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'is not an admin by default' do
    user = User.create(username: 'username', password: 'password')

    expect(user.admin).to be_falsy
  end

  it 'has a downcase username' do
    username = 'UsErNaMe'
    user = User.create(username: username, password: 'password')

    expect(user.username).to eq(username.downcase)
  end

end
