require 'rails_helper'

RSpec.describe 'Session API', type: :request do

  let(:user) { FactoryBot.create(:user) }

  it 'succeed if credentials are correct' do
    post(
      '/login',
      params: {
        username: user.username,
        password: user.password
      }
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data']['attributes']['id']).to eq(user.id)
  end

  it 'throws an error if credentials are incorrect' do
    post(
      '/login',
      params: {
        username: 'wrong username',
        password: 'wrong password'
      }
    )

    expect(response).not_to be_success
  end

end