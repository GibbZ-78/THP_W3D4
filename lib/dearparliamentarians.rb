# dearparliamentarians.rb - Coded with love by JBV for THP "Développeur" Hiver 2022

# Useful includes
require 'open-uri'
require 'nokogiri'

# Useful global vars
$url = "https://www2.assemblee-nationale.fr/deputes/liste/tableau"

# get_french_deputy_info - Given the URL of a chosen French deputy, returns his/her first name, last name and mail address
def get_french_deputy_info(deputy_url)
  scrap_info = []
  page_deputy = Nokogiri::HTML(URI.open(deputy_url))
  scrap_firstname = page_deputy.xpath("").text
  scrap_lastname = page_deputy.xpath("").text
  scrap_mail = page_deputy.xpath("").text
  puts "  > Nom : " + scrap_lastname + " | Prénom : " + scrap_firstname + " | E-mail " + scrap_mail
  return scrap_info = [scrap_firstname, scrap_lasttname.upcase, scrap_mail]
end


# Main method starting the program and calling all others
def dearparliamentarians

end

# Invokation of the main method
dearparliamentarians

# dearparliamentarians.rb - Coded with love by JBV for THP "Développeur" Hiver 2022