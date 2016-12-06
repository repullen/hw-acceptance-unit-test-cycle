Given /the following movies exist:$/ do |movies_table|
   movies_table.hashes.each do |hash|
      Movie.create(title: hash['title'], rating: hash['rating'], release_date: hash['release_date'], director: hash['director']) 
   end
end

