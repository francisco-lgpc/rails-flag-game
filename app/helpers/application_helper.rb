module ApplicationHelper
  def flag_path(country)
    "http://flagpedia.net/data/flags/normal/#{country.code.downcase}.png"
  end

  def colors
    {
      light_grey: "rgba(232, 235, 228, 1)",
      lighter_grey: "rgba(232, 235, 228, .7)",
      sand: "rgba(232, 210, 174, 1)",
      transparent_sand: "rgba(232, 210, 174, .6)",
      grey: "rgba(80, 132, 132, 1)",
      blue: "rgba(28, 110, 140, 1)",
      red: "rgba(255, 111, 89, 1)"
    }
  end
end
