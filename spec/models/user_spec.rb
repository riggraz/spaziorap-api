require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryBot.build_stubbed(:user) }
  
  it 'is not an admin by default' do
    expect(user.admin).to be_falsy
  end

  it 'has a downcase username' do
    username = 'UsErNaMe'
    user = FactoryBot.create(:user, username: username)

    expect(user.username).to eq(username.downcase)
  end

  it 'has a username between 3 and 32 characters' do
    invalid_user = FactoryBot.build_stubbed(:user, username: 'a' * 33)

    expect(user).to be_valid
    expect(invalid_user).not_to be_valid
  end

end
