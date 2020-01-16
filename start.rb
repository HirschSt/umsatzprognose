Dir['./models/*.rb'].each do |file| 
  require file 
end
Dir['./config/config.rb'].each do |file| 
  require file 
end
Dir['./app.rb'].each do |file| 
  require file 
end

require 'date'
require 'ostruct'
require 'csv'
require 'pry'

class Float
  def co
    ('%.2f' %   self).gsub(".", ",")
  end
end

App.main(ARGV[0])
