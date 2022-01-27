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
  #puts scrap_mail
  return scrap_mail
end

# get_cities_urls - Given the base URL of a French department, return the URls of all related cities
def get_cities_urls(base_url)
  tab_cities_urls = []
  page_base = Nokogiri::HTML(URI.open(base_url))
  # old attempt - Xpath given by Chrome Inspector does not seem to work though...
  #scrap_townhall = page_base.xpath("//*[@id='voyance-par-telephone']/table/tbody/tr[2]/td/table/tbody/tr/*/p/a")
  # alternate attempt - Using the "@href" value to get directluy the "href" attribute
  #scrap_townhall = page_base.xpath("//*/a[@class='lientxt']/@href") - Not used because already building the URL another way
  scrap_townhall = page_base.xpath("//*/a[@class='lientxt']") # version simplifiée
  scrap_townhall.each do |lien|
    lien1 = lien.text.downcase.gsub(" ","-")
    tab_cities_urls.push([lien1, $url2+lien1]) 
  end
  # puts tab_cities_urls
  return tab_cities_urls
end

# Main method starting the program and calling all others
def mairiechristmas
  
  my_townhall_name = []
  my_townhall_mail = []
  my_townhall_tab = []

  # DEBUG
  # puts
  # puts get_townhall_mail("https://www.annuaire-des-mairies.com/95/ableiges.html")
  # puts
  # puts get_cities_urls($url1)
  # puts
  
  get_cities_urls($url1).each do |city|
    my_townhall_name.push(city[0])
    my_townhall_mail.push(get_townhall_mail(city[1]))
  end

  for i in 0...my_townhall_name.length do
    my_townhall_hash = Hash.new
    my_townhall_hash[my_townhall_name[i]] = my_townhall_mail[i] # On pourrait transformer les clés String en Symbols
    my_townhall_tab.push(my_townhall_hash)
  end

  puts my_townhall_tab

end

# Invokation of the main method
mairiechristmas

# mairiechristmas.rb - Coded with love by JBV for THP "Développeur" Hiver 2022