require 'flickraw'
require 'yaml'

auth_config_yaml = YAML.load_file('flickr-config.yaml')
FlickRaw.api_key = auth_config_yaml["api_key"]
FlickRaw.shared_secret = auth_config_yaml["shared_secret"]
flickr.access_token = auth_config_yaml["access_token"]
flickr.access_secret = auth_config_yaml["access_secret"]

# From here you are logged:
login = flickr.test.login
puts "You are now authenticated as #{login.username}"

list = flickr.photos.recentlyUpdated(min_date: '2010-04-06 21:42:21', per_page: 10).map {|photo|
  flickr.photos.getInfo photo_id: photo.id, secret: photo.secret    
}

list.sort! { |f1, f2|
  f1.dates.taken <=> f2.dates.taken
}

list.each { |f|
  puts f.title           # => "PICT986"
  puts f.dates.taken     # => "2006-07-06 15:16:18"
  puts FlickRaw.url_t(f) # Thumbnail URL    
}

#id     = list[0].id
#secret = list[0].secret
#info = flickr.photos.getInfo :photo_id => id, :secret => secret

#uts info.title           # => "PICT986"
#puts info.dates.taken     # => "2006-07-06 15:16:18"
#puts FlickRaw.url_t(info)

#sizes = flickr.photos.getSizes :photo_id => id

#original = sizes.find {|s| s.label == 'Original' }
