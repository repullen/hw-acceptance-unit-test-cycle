Then /^the director of "(.*)" should be "(.*)"$/ do |title_val, director_val|
    movie = Movie.find_by_title(title_val)
    expect(movie.director).to eq director_val
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #p1 = (page.body =~ /#{e1}/)
  #p2 = (page.body =~ /#{e2}/)
  
  #assert p1, "Page does not contain #{e1}"
  #assert p2, "Page does not contain #{e2}"
  #assert p1 < p2, "#{e1} occurs at #{p1}, and #{e2} occurs at #{p2}"
  
  body = page.body
  location_of_e1_in_body = body.index(e1)
  location_of_e2_in_body = body.index(e2)
  loc1 = location_of_e1_in_body
  loc2 = location_of_e2_in_body
  if loc1 == nil || loc2 == nil
      fail "One of both search parameters not found"
  else
      expect(loc1 < loc2).to eq true
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end

Then /I should see all the movies/ do
  rows = page.all("table#movies>tbody tr").count
  expect(rows).to eq Movie.count
  
  #movies = Movie.all
  #movies.each do |movie|
    #assert page.body =~ /#{movie.title}/, "Missing #{movie.title}"
  #end
end
