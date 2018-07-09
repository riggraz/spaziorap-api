require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { FactoryBot.build_stubbed(:topic) }

  it 'has a name between 3 and 32 characters' do
    short_topic = FactoryBot.build_stubbed(:topic, name: 'a' * 2)
    long_topic = FactoryBot.build_stubbed(:topic, name: 'a' * 33)

    expect(topic).to be_valid
    expect(short_topic).not_to be_valid
    expect(long_topic).not_to be_valid
  end
end
