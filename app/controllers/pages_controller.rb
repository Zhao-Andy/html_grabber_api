class PagesController < ApplicationController
  def parse
    require 'open-uri'
    doc = Nokogiri::HTML(open(params[:url]))
    content = Content.new(origin_url: params[:url])
    doc.search('h1').each { |e| content.h1.push(e.text) }
    doc.search('h2').each { |e| content.h2.push(e.text) }
    doc.search('h3').each { |e| content.h3.push(e.text) }
    doc.search('a').each { |e| content.links.push(e.attributes["href"].value) }
    content.save if content.valid?
  end

  def index
    @content = Content.all
    render 'index.json.jbuilder'
  end

  def show
  end
end
