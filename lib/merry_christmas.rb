require 'rubygems'
require 'nokogiri'
require 'open-uri'

def connect 
  page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html")) # faire le lien avec la page HTML 

  townhalls = Array.new(0) # variable qui va ittérer a chaque les listes dans le tableau 

  page.css('//a[@class=lientxt]/@href').each.with_index do |href, index| # boucle pour extraire les informations
    complete_url = "http://annuaire-des-mairies.com/#{href.to_s[2, href.to_s.length]}" 
    # variable complete_url : permet choisir le lien de chaque mairie
    townhall = Nokogiri::HTML(URI.open(complete_url))
    # variable townhall permet faire le lien avec chaque maire de l'oise "complete_url"  pour récupérer les adresse  mail
    city = townhall.css("h1")[1].text.split(" - ")[0].to_s
    # variable city pemet de récuperer les noms des villes  avec H1 et split pour mettre des - et converti en string  
    # [1] [0] sont utiliser pour retirer le codepostal et afficher le nom des villes 
    email = townhall.css("tr.txt-primary")[3].css("td")[1].text.to_s
    # variable email permet de récuperer les emails 
    townhalls[index] = { city => email } 
    #  variable townhalls[index] permet de mettre les deux hashs dauns une liste pour regrouper 
    puts "La mairie de #{city} a l'adresse email #{email}"
    # on affiche le résultat
  end

  return townhalls
end

connect()