Dir['./models/*.rb'].each do |file| 
  require file 
end
Dir['./config.rb'].each do |file| 
  require file 
end
Dir['./app.rb'].each do |file| 
  require file 
end


require 'date'
require 'ostruct'
require 'csv'


class Float
  def co
    ('%.2f' %   self).gsub(".", ",")
  end
end

