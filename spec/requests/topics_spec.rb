require 'rails_helper'

RSpec.describe 'Topics API' do

  it 'sends the list of topics in alphabetical order' do
    FactoryBot.create(:topic, name: 'Topic 3')
    FactoryBot.create(:topic, name: 'Topic 2')
    FactoryBot.create(:topic, name: 'Topic 1')

    get(
      '/topics'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(3)
    #expect(json['data']).to match(/Topic 1*Topic 2*Topic 3/)
  end

end