require 'rails_helper'

RSpec.describe 'Posts API' do

  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:post1) { FactoryBot.create(:post) }
  let(:post2) { FactoryBot.create(:post) }

  # # GET /posts/:id/likes
  # it 'returns the specified Post score (calculated on Likes)' do
  #   Like.create(score: 1, user_id: user1.id, post_id: post1.id)
  #   Like.create(score: 1, user_id: user2.id, post_id: post1.id)

  #   get(
  #     "/posts/#{post1.id}/likes"
  #   )

  #   json = JSON.parse(response.body)

  #   expect(response).to be_success
  #   expect(json).to eq(2)

  #   Like.create(score: -1, user_id: user1.id, post_id: post2.id)
  #   Like.create(score: 1, user_id: user2.id, post_id: post2.id)

  #   get(
  #     "/posts/#{post2.id}/likes"
  #   )

  #   json = JSON.parse(response.body)

  #   expect(response).to be_success
  #   expect(json).to eq(0)
  # end

  # POST /posts/:id/likes
  it 'create or update Like of specified Post' do
    # Like
    # Set score to 1
    post(
      "/posts/#{post1.id}/likes",
      params: {
        score: 1,
        post_id: post1.id
      },
      headers: {
        'Authorization': user1.access_token
      }
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data']['attributes']['score']).to eq(1)

    # Dislike
    # Set score to -1
    post(
      "/posts/#{post1.id}/likes",
      params: {
        score: -1,
        post_id: post1.id
      },
      headers: {
        'Authorization': user1.access_token
      }
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data']['attributes']['score']).to eq(-1)

    # Undislike
    # Because score is already -1, score should be set to 0
    post(
      "/posts/#{post1.id}/likes",
      params: {
        score: -1,
        post_id: post1.id
      },
      headers: {
        'Authorization': user1.access_token
      }
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data']['attributes']['score']).to eq(0)
  end

end