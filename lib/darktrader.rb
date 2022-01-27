#darktrader.rb - Coded with love by JBV for THP "Développeur" Hiver 2022

# Useful includes
require 'open-uri'
require 'nokogiri'

# Useful global vars
$url = "https://coinmarketcap.com/all/views/all/"





# Main method starting the program and calling all others
def darktrader
  page = Nokogiri::HTML(URI.open($url))
  devises = page.xpath(('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--hide-sm cmc-table__cell--sort-by__symbol"]'))
  valorisations = page.xpath(('//a[@class="cmc-link"]'))
  # puts devises
  # puts "********"
  puts valorisations
end

# Invokation of the main method
darktrader

#darktrader.rb - Coded with love by JBV for THP "Développeur" Hiver 2022