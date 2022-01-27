#darktrader.rb - Coded with love by JBV for THP "Développeur" Hiver 2022

# Useful includes
require 'open-uri'
require 'nokogiri'

# Useful global vars
$url = "https://coinmarketcap.com/all/views/all/"

# Main method - Starting and organizaing the program and calling all others
def darktrader
  # Vars initialization
  debug = "DEBUG > "
  currency_name = []
  currency_code = []
  currency_value = []
  my_crypto_hash = {}
  my_crypto_tab = []

  # HTML flow opening and loading, then filtering into 3 "Nodesets"
  page = Nokogiri::HTML(URI.open($url))
  scrap_code = page.xpath("//*[@id='__next']/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/*/td[2]/div/a[1]") #Exemple : BTC
  scrap_name = page.xpath("//*[@id='__next']/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/*/td[2]/div/a[2]") #Exemple : Bitcoin
  scrap_value = page.xpath("//*[@id='__next']/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/*/td[5]/div/a/span") #Exemple : 3656.45
  
  # DEBUG
  # puts page.class
  # puts scrap_code.class
  # puts scrap_name.class
  # puts scrap_value.class

  #
  scrap_name.each do |name|
    currency_name.push(name.text)
    # DEBUG
    # puts debug+name.text
  end

  scrap_code.each do |code|
    currency_code.push(code.text)
    # DEBUG
    # puts debug+code.text
  end

  scrap_value.each do |value|
    currency_value.push(value.text.delete("$,").to_f)
    # DEBUG
    # puts debug+value.text
  end

  # DEBUG
  # print currency_name
  # puts "**************************"
  # puts currency_code
  # puts "**************************"
  # puts currency_value
  # puts "**************************"

  for i in 0...currency_name.length do
    # Old attempt... Did not get why it doesn't work yet
    # my_crypto_hash = {currency_name[i].to_s.to_sym => currency_value[i]}
    my_crypto_hash = Hash.new
    my_crypto_hash[currency_code[i].to_sym] = [currency_name[i], currency_value[i]]
    puts debug+"Code: #{currency_code[i]}  -  Name: #{currency_name[i]}  -  Value: #{currency_value[i]}"
    my_crypto_tab.push(my_crypto_hash)
  end

  puts my_crypto_tab

end

# Invokation of the main method
darktrader

#darktrader.rb - Coded with love by JBV for THP "Développeur" Hiver 2022