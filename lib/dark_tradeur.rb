require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_currencies
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")) # pour faire le lien avec la page internet 

  cryptos = Array.new(0) # variable qui va ittérer a chaque les listes dans le tableau 

  page.css(".cmc-table-row").each.with_index do |line, index| # boucle pour extraire les informations
    
    symbol = line.css(".cmc-table__cell--sort-by__symbol").text  # variable pour récupérer les liste des symbols 
    price = line.css(".cmc-table__cell--sort-by__price").text.gsub("$", "").gsub(",", "").to_f # variable pour récupérer les liste des prix 
                                                                                                 # ensuite il supprime les $ .gsub
                                                                                                 # apres il convertit en float 
    cryptos[index] = { symbol => price } # On met les Hashs dans un Array

    puts "(#{index}) :" + cryptos[index].to_s  # affiche les donnés  et converti en string 

  end

  return cryptos
end

get_currencies()
