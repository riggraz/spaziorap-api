require 'rails_helper'

RSpec.describe 'Users API' do

  it 'creates a new user' do
    expect(User.count).to eq(0)

    post(
      '/users',
      params: {
        user: {
          username: 'username',
          password: 'password'
        }
      }
    )

    expect(response).to be_success
    expect(User.count).to eq(1)
  end

end