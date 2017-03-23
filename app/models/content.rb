class Content < ApplicationRecord
  belongs_to :user

  def parse_elements(page)
    page.search('h1').each { |e| h1.push(e.text) }
    page.search('h2').each { |e| h2.push(e.text) }
    page.search('h3').each { |e| h3.push(e.text) }
    page.search('a').each  { |e| links.push(e.attributes["href"].value) }
  end
end
