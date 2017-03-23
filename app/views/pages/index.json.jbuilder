json.array! @content.each do |element|
  json.partial! 'content.json.jbuilder', element: element
end
