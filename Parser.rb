# frozen_string_literal: true
require 'nokogiri'
require 'csv'
require 'open-uri'
doc = Nokogiri::HTML(URI.open('https://www.hospitalsafetygrade.org/all-hospitals'))
hospitals = doc.css('div#BlinkDBContent_849210 li a')
CSV.open("hospitals.csv", "w") do |csv|
  csv<<["ID", "Hospital", "URL"]
  i=-1
  hospitals.each do |hospital|
    i+=1
    #docloc=Nokogiri::HTML(URI.open(''))
    #location =  
    name = hospital.text
    url=hospital['href']
    csv <<[i, name, url]
  end
end

