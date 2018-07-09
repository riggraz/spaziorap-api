require 'rails_helper'

RSpec.describe 'Posts API' do

  it 'sends the latest 50 posts' do
    user = FactoryBot.create(:user)
    FactoryBot.create_list(:post, 51, user: user)

    get(
      '/posts'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(50)
  end

end