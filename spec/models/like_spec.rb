require 'rails_helper'

RSpec.describe Like, type: :model do
  
  let(:post) { FactoryBot.create(:post) }
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }

  it 'has a score of -1, 0 or 1' do
    like1 = Like.create(score: -1, post_id: post.id, user_id: user1.id)
    like2 = Like.create(score: 0, post_id: post.id, user_id: user2.id)
    like3 = Like.create(score: 1, post_id: post.id, user_id: user3.id)
    like4 = Like.create(score: 6, post_id: post.id, user_id: user4.id)

    expect(like1).to be_valid
    expect(like2).to be_valid
    expect(like3).to be_valid
    expect(like4).not_to be_valid
  end

end
