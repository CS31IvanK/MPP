# frozen_string_literal: true
require 'nokogiri'
require 'csv'
require 'open-uri'
doc = Nokogiri::HTML(URI.open('https://www.hospitalsafetygrade.org/all-hospitals'))
hospitals = doc.css('div#BlinkDBContent_849210 li a')
CSV.open("hospitals.csv", "w") do |csv|
  csv<<["Hospital", "URL"]
  hospitals.each do |hospital|
    name = hospital.text
    url=hospital['href']
    csv <<[name, url]
  end
end

