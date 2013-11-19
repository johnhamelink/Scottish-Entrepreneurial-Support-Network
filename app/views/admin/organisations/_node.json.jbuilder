require 'digest/sha1'

json.id Digest::SHA1.hexdigest("#{node.id}-#{node.name}-#{node.blurb}")
json.name node.name
json.data do |json|
  json.blurb simple_format node.blurb
  json.logo do |json|
    if node.logo.exists?
      json.thumb    asset_url(node.logo(:thumb))
      json.original asset_url(node.logo.url)
    else
      json.thumb image_url "node.png"
      json.original image_url "node.png"
    end
  end
  json.search_types node.search_types do |search_type|
    json.array! search_type.searches.map {|m| m.search }
  end
  json.url node.url
end
json.children node.children do |json, node|
  json.partial! 'node', node: node
end
