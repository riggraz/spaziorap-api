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
    post = FactoryBot.create(:post, body: 'Simple Body', user: user)

    get(
      "/posts/#{post.id}"
    )

    post_json = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_success
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

  # DELETE /posts/:id
  it 'does not delete the specified post even though you created it' do
    post = FactoryBot.create(:post, user: user)
    user2 = FactoryBot.create(:user)

    expect(Post.count).to eq(1)

    delete(
      "/posts/#{post.id}",
      headers: {
        'Authorization': user2.access_token
      }
    )

    expect(response).to be_forbidden
    expect(Post.count).to eq(1)

    delete(
      "/posts/#{post.id}",
      headers: {
        'Authorization': user.access_token
      }
    )

    expect(response).to be_forbidden
    expect(Post.count).to eq(1)
  end

  it 'deletes the specified post if you are admin' do
    admin = FactoryBot.create(:user, admin: true)
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user: user)

    expect(Post.count).to eq(1)

    delete(
      "/posts/#{post.id}",
      headers: {
        'Authorization': admin.access_token
      }
    )

    expect(response).to be_success
    expect(Post.count).to eq(0)
  end

  # GET /posts/latest
  it 'sends the latest posts paginated by 10' do
    FactoryBot.create_list(:post, 11, user: user)

    get(
      '/posts/latest'
    )

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(10)
  end

end