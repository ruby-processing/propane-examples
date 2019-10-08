%w[box boundary spring dummy_spring].each do |lib|
  require_relative File.join('lib',"#{lib}")
end
