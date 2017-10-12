require 'rubygems'
require 'open-uri'
require 'nokogiri'

def get_crypto_price_name
	crypto_price = []
	crypto_name = []

	doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	doc.xpath('.//*[@class="price"]').each do |price_crypto|
	crypto_price << price_crypto.text
	end

	doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
	doc.xpath('.//*[@class="no-wrap currency-name"]//a').each do |name_crypto|
	crypto_name << name_crypto.text
	end
	
	final_hash = crypto_name.zip(crypto_price).map { |crypto_name, crypto_price| {crypto_name: crypto_name, crypto_price: crypto_price}}
	puts final_hash
end

get_crypto_price_name()

