# dearparliamentarians.rb - Coded with love by JBV for THP "Développeur" Hiver 2022

# Useful includes
require 'open-uri'
require 'nokogiri'

# Useful global vars
$url = "https://www2.assemblee-nationale.fr/"
$url_tableau = $url+"deputes/liste/tableau"

# get_french_deputy_info - Given the URL of a chosen French deputy, returns his/her first name, last name and mail address
def get_french_deputy_info(deputy_url)
  scrap_info = []
  page_deputy = Nokogiri::HTML(URI.open(deputy_url))
  scrap_name = page_deputy.xpath("/html/body/div/div[2]/div/div/div/section[1]/div/article/div[2]/h1").text.split
  scrap_firstname = scrap_name[1]
  scrap_lastname = scrap_name[2]
  scrap_mail = page_deputy.xpath("/html/body/div/div[2]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
  # DEBUG
  # puts "  > Nom : " + scrap_lastname + " | Prénom : " + scrap_firstname + " | E-mail : " + scrap_mail
  return scrap_info = [scrap_firstname, scrap_lastname.upcase, scrap_mail]
end

# get_deputies_urls - Given the base URL of a The Assemblée Nationale, return the URls of all related parliamantarians
def get_deputies_urls(base_url)
  puts "début"
  tab_deputies_urls = []
  page_base = Nokogiri::HTML(URI.open(base_url))
  # scrap_deputies = page_base.xpath("/html/body/div/div[2]/div/div/section/div/article/div[3]/div/div/table/tbody/*/td[1]/a")
  # scrap_deputies = page_base.xpath("//*/td[@class='sorting_1']/a/@href")
  # scrap_deputies = page_base.xpath("*/td[@class='sorting_1']/a/@href")
  scrap_deputies = page_base.xpath("//*[@class='deputes']/tbody//*/a/@href")
  scrap_deputies.each do |lien|
    lien1 = $url+lien.text[1..-1]
    tab_deputies_urls.push(lien1) 
  end
  # puts tab_deputies_urls
  return tab_deputies_urls
end


# Main method starting the program and calling all others
def dearparliamentarians
  my_deputy_tab = []
  my_final_tab = []

  # DEBUG
  toto = get_french_deputy_info("https://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")
  puts toto
  puts 
  titi = get_deputies_urls($url_tableau)
  puts titi[0]
  puts titi[1]

  puts
  print "Collecting URLs"
  get_deputies_urls($url_tableau).each do |deputy_url|
    my_deputy_tab.push(get_french_deputy_info(deputy_url))
    print "."
  end

  puts
  puts
  print "Building hash"
  for i in 0...my_deputy_tab.length do
    my_deputy_hash = Hash.new
    my_deputy_hash["first_name"] = my_deputy_tab[i][0]
    my_deputy_hash["last_name"] = my_deputy_tab[i][1]
    my_deputy_hash["email"] = my_deputy_tab[i][2]
    my_final_tab.push(my_deputy_hash)
    print "."
  end

  puts
  puts
  puts "Here is the final result :"
  puts
  puts my_final_tab

end

# Invokation of the main method
dearparliamentarians

# dearparliamentarians.rb - Coded with love by JBV for THP "Développeur" Hiver 2022