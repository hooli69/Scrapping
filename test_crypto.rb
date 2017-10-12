require 'rubygems'
require 'open-uri'
require 'nokogiri'

def crypto_bis
	doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	doc.xpath('.//*[@class="no-wrap currency-name"]//a').each do |name_crypto|
		puts name_crypto.text
	end
end

crypto_bis()