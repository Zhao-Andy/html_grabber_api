require "rails_helper"

RSpec.describe Content, type: :model do
  describe "rails validations" do
    it 'validates that content must have user_id' do
      invalid_content = Content.create(origin_url: 'some_link')
      expect(invalid_content.errors.full_messages.first).to eq("User must exist")
    end

    it 'validates h1 attribute is an array' do
      content = Content.create
      expect(content.h1.is_a?(Array)).to eq(true)
    end

    it 'validates h2 attribute is an array' do
      content = Content.create
      expect(content.h2.is_a?(Array)).to eq(true)
    end

    it 'validates h3 attribute is an array' do
      content = Content.create
      expect(content.h3.is_a?(Array)).to eq(true)
    end

    it 'validates links attribute is an array' do
      content = Content.create
      expect(content.links.is_a?(Array)).to eq(true)
    end

    it 'validates h1 attribute can be empty' do
      content = Content.create
      expect(content.h1.empty?).to eq(true)
    end

    it 'validates h2 attribute can be empty' do
      content = Content.create
      expect(content.h2.empty?).to eq(true)
    end

    it 'validates h3 attribute can be empty' do
      content = Content.create
      expect(content.h3.empty?).to eq(true)
    end

    it 'validates links attribute can be empty' do
      content = Content.create
      expect(content.links.empty?).to eq(true)
    end
  end
  describe "#parse_elements" do
    it 'checks that parse_elements method pushes
        h1 elements into the h1 attribute of content' do
      content = Content.create(origin_url: 'https://zhao-andy.github.io', user_id: 1)
      require 'open-uri'
      page = Nokogiri::HTML(open('https://zhao-andy.github.io'))
      content.parse_elements(page)
      expect(content.h1).to eq(["First H1", "Second H1"])
    end

    it 'checks that parse_elements method pushes
        h2 elements into the h2 attribute of content' do
      content = Content.create(origin_url: 'https://zhao-andy.github.io', user_id: 1)
      require 'open-uri'
      page = Nokogiri::HTML(open('https://zhao-andy.github.io'))
      content.parse_elements(page)
      expect(content.h2).to eq(["First H2", "Second H2"])
    end

    it 'checks that parse_elements method pushes
        h3 elements into the h3 attribute of content' do
      content = Content.create(origin_url: 'https://zhao-andy.github.io', user_id: 1)
      require 'open-uri'
      page = Nokogiri::HTML(open('https://zhao-andy.github.io'))
      content.parse_elements(page)
      expect(content.h3).to eq(["First H3", "Second H3"])
    end

    it 'checks that parse_elements method pushes
        a-tag elements into the links attribute of content' do
      content = Content.create(origin_url: 'https://zhao-andy.github.io', user_id: 1)
      require 'open-uri'
      page = Nokogiri::HTML(open('https://zhao-andy.github.io'))
      content.parse_elements(page)
      expect(content.links).to eq(["https://zhao-andy.github.io", "https://www.google.com"])
    end
  end
end
