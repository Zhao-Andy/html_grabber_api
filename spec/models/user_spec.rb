require "rails_helper"

RSpec.describe User, type: :model do
  describe "rails validations" do
    it 'validates email attribute is not blank' do
      user = User.new(email: "", api_key: "123")
      expect(user.errors.full_messages.first).to eq("Email can't be blank")
    end

    it 'validates api_key attribute is not blank' do
      user = User.new(email: "user@ex.com", api_key: "")
      expect(user.errors.full_messages.first).to eq("Api key can't be blank")
    end

    it 'creates a valid user' do
      user = User.create(email: "test@ex.com", api_key: '123')
      expect(user.valid?).to eq(true)
    end

    it 'prevents creating a user with the same email' do
      user = User.create(email: "test@ex.com", api_key: '123')
      invalid_user = User.new(email: "test@ex.com", api_key: '321')
      user.save
      expect(invalid_user.errors.full_messages.first).to eq("Email has already been taken")
    end

    it 'prevents creating a user with the same api_key' do
      user = User.create(email: "user@ex.com", api_key: '123')
      invalid_user = User.new(email: "test@ex.com", api_key: '123')
      user.save
      expect(invalid_user.errors.full_messages.first).to eq("Api key has already been taken")
    end

    it 'checks that a user has_many contents by calling the contents method on a user' do
      user = User.create(email: "user@ex.com", api_key: '123')
      content = Content.create(origin_url: 'some_link', user_id: user.id)
      expect(user.contents.exists?).to eq(true)
    end
  end
end
