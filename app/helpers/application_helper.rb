module ApplicationHelper
  def flag_path(country)
    "http://flagpedia.net/data/flags/normal/#{country.code.downcase}.png"
  end
end
