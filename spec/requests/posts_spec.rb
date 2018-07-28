require 'rails_helper'

RSpec.describe 'Posts API' do

  let(:user) { FactoryBot.create(:user) }

  # GET /topics/:id/posts
  it 'sends posts of specified topic' do
    topic1 = FactoryBot.create(:topic)
    topic2 = FactoryBot.create(:topic)

    FactoryBot.create(:post, topic: topic1)
    FactoryBot.create(:post, topic: topic2)

    get(
      "/topics/#{topic1.id}/posts"
    )

    json = JSON.parse(response.body)

    expect(json['data'].length).to eq(1)
  end

  # GET /users/:id/posts
  it 'sends posts of specified user' do
    user2 = FactoryBot.create(:user)

    FactoryBot.create(:post, user: user)
    FactoryBot.create(:post, user: user)
    FactoryBot.create(:post, user: user2)

    get(
      "/users/#{user.id}/posts"
    )

    json = JSON.parse(response.body)

    expect(json['data'].length).to eq(2)
  end

  # GET /posts/:id
  it 'sends the specified post' do
    post = FactoryBot.create(:post, title: 'Simple Title', body: 'Simple Body', user: user)

    get(
      "/posts/#{post.id}"
    )

    post_json = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_success
    expect(post_json['title']).to eq('Simple Title')
    expect(post_json['body']).to eq('Simple Body')
  end

  # POST /posts
  it 'creates a new post' do
    user = FactoryBot.create(:user)
    topic = FactoryBot.create(:topic)

    expect(Post.count).to eq(0)

    post(
      '/posts',
      params: {
        post: {
          title: 'Title',
          body: 'Body',
          topic_id: topic.id
        }
      },
      headers: {
        'Authorization': user.access_token
      }
    )

    expect(response).to be_success
    expect(Post.count).to eq(1)
  end

  # GET /posts/latest
  it 'sends the latest 50 posts' do
    FactoryBot.create_list(:post, 51, user: user)

    get(
      '/posts/latest'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(50)
  end

end