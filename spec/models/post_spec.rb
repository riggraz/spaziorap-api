require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) { FactoryBot.build_stubbed(:post) }
  
  it 'has a title between 3 and 64 characters' do
    short_post = FactoryBot.build_stubbed(:post, title: 'a' * 2)
    long_post = FactoryBot.build_stubbed(:post, title: 'a' * 65)

    expect(post).to be_valid
    expect(short_post).not_to be_valid
    expect(long_post).not_to be_valid
  end

end
