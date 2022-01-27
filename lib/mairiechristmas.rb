# mairiechristmas.rb - Coded with love by JBV for THP "Développeur" Hiver 2022

# Useful includes
require 'open-uri'
require 'nokogiri'

# Useful global vars
$url1 = "https://www.annuaire-des-mairies.com/val-d-oise.html"
$url2 = "https://www.annuaire-des-mairies.com/95/"

# get_townhall_mail - Given the URL of a given city, return the related mail address
def get_townhall_mail(townhall_url)
  page_townhall = Nokogiri::HTML(URI.open(townhall_url))
  scrap_mail = page_townhall.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text
  puts scrap_mail
  return scrap_mail
end

# get_cities_urls - Given the base URL of a French department, return the URls of all related cities
def get_cities_urls(base_url)
  tab_cities_urls = []
  page_base = Nokogiri::HTML(URI.open(base_url))
  scrap_townhall = page_base.xpath("//*[@id='voyance-par-telephone']/table/tbody/tr[2]/td/table/tbody/tr/*/p/a")
  scrap_townhall.each do |lien|
    lien1 = lien.text
    tab_cities_urls.push($url2+lien1.downcase.gsub(" ","-")) 
  end
  puts tab_cities_urls
  return tab_cities_urls
end

# Main method starting the program and calling all others
def mairiechristmas
  
  # get_cities_urls($url1).each do |city_url|
  #   get_townhall_mail(city_url)
  # end
  puts
  puts get_townhall_mail("https://www.annuaire-des-mairies.com/95/ableiges.html")
  puts
  puts get_cities_urls($url1)
  puts

end

# Invokation of the main method
mairiechristmas

# mairiechristmas.rb - Coded with love by JBV for THP "Développeur" Hiver 2022