require 'rails_helper'

RSpec.describe 'Topics API' do

  it 'sends the list of topics' do
    n = 10
    FactoryBot.create_list(:topic, n)

    get(
      '/topics'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(n)
  end

end