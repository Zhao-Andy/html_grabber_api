require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  describe 'GET #root' do
    it 'responds successfully with an HTTP 200 status code' do
      get :root
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #index' do
    it 'responds unsuccessfully with an HTTP 401 status code' do
      get :index
      expect(response).to have_http_status(401)
    end

    it 'responds successfully with an HTTP 200 status code when a valid user is given' do
      user = User.create(email: 'user@ex.com', api_key: SecureRandom.base64(16))
      request.headers["accept"] = 'application/json'
      request.headers['Authorization'] = "Token token=#{user.api_key}"
      request.headers['X-User-Email'] = user.email
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'responds successfully with JSON data' do
      user = User.create(email: 'user@ex.com', api_key: SecureRandom.base64(16))
      content = Content.create(origin_url: 'some_link', h1: [1,2,3], user_id: user.id)
      request.headers["accept"] = 'application/json'
      request.headers['Authorization'] = "Token token=#{user.api_key}"
      request.headers['X-User-Email'] = user.email
      get :index
      json_data = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_data[0]['origin_url']).to eq(content.origin_url)
    end


    it "responds successfully with only data belonging to the user" do
      user = User.create(email: 'user@ex.com', api_key: SecureRandom.base64(16))
      Content.create(origin_url: 'some_link', h1: [1,2,3], user_id: user.id)
      Content.create(origin_url: 'other_users_link', h1: [1,2,3], user_id: 1)
      request.headers["accept"] = 'application/json'
      request.headers['Authorization'] = "Token token=#{user.api_key}"
      request.headers['X-User-Email'] = user.email
      get :index, format: :json
      json_data = JSON.parse(response.body)
      has_other_user_content = false
      json_data.each { |entry| has_other_user_content = true if entry.has_value?('other_users_link') }
      expect(response).to be_success
      expect(has_other_user_content).to eq(false)
    end
  end

  describe 'GET #show' do
    it 'responds unsuccessfully with an HTTP 401 status code when there are no headers' do
      get :show
      expect(response).to have_http_status(401)
    end

    it 'responds successfully with JSON data' do
      user = User.create(email: 'user@ex.com', api_key: SecureRandom.base64(16))
      content = Content.create(origin_url: 'some_link', h1: [1,2,3], user_id: user.id)
      request.headers["accept"] = 'application/json'
      request.headers['Authorization'] = "Token token=#{user.api_key}"
      request.headers['X-User-Email'] = user.email
      get :show, params: { :url => content.origin_url }
      json_data = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_data['origin_url']).to eq(content.origin_url)
    end

    it "responds successfully with only data belonging to the user" do
      user = User.create(id: 2, email: 'user@ex.com', api_key: SecureRandom.base64(16))
      other_user_content = Content.create(origin_url: 'other_users_link', h1: [1,2,3], user_id: 1)
      request.headers["accept"] = 'application/json'
      request.headers['Authorization'] = "Token token=#{user.api_key}"
      request.headers['X-User-Email'] = user.email
      get :show, params: { :url => other_user_content.origin_url }
      json_data = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(json_data.has_value?("You don't have that link!")).to eq(true)
      # expect(json_data.has_value?('other_users_link')).to eq(false)
    end
  end
end
