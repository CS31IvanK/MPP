# frozen_string_literal: true
require 'nokogiri'
require 'csv'
require 'open-uri'
doc = Nokogiri::HTML(URI.open('https://www.hospitalsafetygrade.org/all-hospitals'))
hospitals = doc.css('div#BlinkDBContent_849210 li a')
CSV.open("hospitals.csv", "wb") do |csv|
  csv<<["ID", "Hospital", "URL"]#, "Location"]
  i=-1
  hospitals.each do |hospital|
    i+=1
    name = hospital.text
    url=hospital['href']
    #docloc=Nokogiri::HTML(URI.open(url))
    #location = docloc.css('div.address').inner_html.split('<br>')[0..1].join()
    #puts location
    csv <<[i, name, url]#, location]
  end
end
