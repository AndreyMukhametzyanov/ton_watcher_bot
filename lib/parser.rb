require 'nokogiri'
require 'open-uri'
require 'watir'

class Parser
  def self.html_into_massive(address)
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto "https://tonwhales.com/staking/address/#{address}"

    doc = Nokogiri::HTML(browser.html, nil, 'UTF-8')

    headers = []
    doc.xpath('//*/table/thead/th').each do |th|
      headers << th.text
    end

    lines = []
    doc.xpath('//*/table/tr').each_with_index do |row, i|
      lines[i] = {}
      row.xpath('td').each_with_index do |td, j|
        lines[i][headers[j]] = td.text
      end
    end
    lines
  end
end
