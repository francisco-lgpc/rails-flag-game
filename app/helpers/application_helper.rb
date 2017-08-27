module ApplicationHelper
  def flag_path(country)
    "http://flagpedia.net/data/flags/normal/#{country.code}.png"
  end
end
