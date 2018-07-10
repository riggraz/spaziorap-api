require 'rails_helper'

RSpec.describe 'Posts API' do

  let(:user) { FactoryBot.create(:user) }

  # GET /posts
  it 'sends the latest 50 posts' do
    FactoryBot.create_list(:post, 51, user: user)

    get(
      '/posts'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(50)
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

end