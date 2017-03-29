class PagesController < ApplicationController
  def root
    @session = User.new
  end

  def create
    require 'open-uri'
    doc = Nokogiri::HTML(open(params[:url]))
    content = Content.new(origin_url: params[:url], user_id: @user.id)
    content.parse_elements(doc)
    content.save
    redirect_to "/show.json/#{content.url}"
  end

  def index
    @content = Content.where(user_id: @user.id)
  end

  def show
    @content = Content.find_by(origin_url: params[:url], user_id: @user.id)
    render json: { error: "You don't have that link!" }, status: 422 if @content.nil?
  end
end
