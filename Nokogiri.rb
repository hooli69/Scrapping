require 'rubygems'
require 'open-uri'
require 'nokogiri'

def get_the_email_of_a_townhal_from_its_webpage(url, mairie)
	#on crée un tableau my emails qu'on va appeler pour stocker les données sur la ligne 12
	my_emails = []
	final_hash = []
	#fonction 'each'pour aller chercher toutes les url
	url.each do |page_url|
		doc = Nokogiri::HTML(open(page_url))
		a = doc.xpath('.//*[@class = "Style22"]')
		#on les stocks dans le tableau mes emails
		my_emails << a[11].text[1..-1]
	end
	#.zip permet de concatener 2 méthodes
	final_hash = mairie.zip(my_emails).map { |ville, email| {ville: ville, email: email} }
	puts final_hash
end

def get_all_the_urls_of_val_doise_townhalls
	doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	# on crée un tableau tabl empty pour stocker nos url
	tabl = []
	# On crée un tableau Mairie pour stocker les noms de la mairie
	mairie = []
	doc.xpath('.//*[@class="lientxt"]/@href').each do |node|
		# On ajoute les url annuaire des mairies au tableau 'tabl' et on retire le point grâce à 1..-1 car on a les adresses en .marieenquestion.html sans le premier le http
		tabl << "http://annuaire-des-mairies.com/#{node.text[1..-1]}"
	end
	doc.xpath('.//*[@class="lientxt"]').each do |node|
		#On ajoute nos noms de mairie dans notre tableau 'mairie'
		mairie << node.text
	end

	get_the_email_of_a_townhal_from_its_webpage(tabl, mairie)
end

#on appelle notre fonction principale
get_all_the_urls_of_val_doise_townhalls()


