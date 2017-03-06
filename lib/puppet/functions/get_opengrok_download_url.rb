require 'httparty'
require 'nokogiri'

Puppet::Functions.create_function(:get_opengrok_download_url) do
  dispatch :get do
    param 'String', :opengrok_version
  end

  def get(opengrok_version)
    baseurl = 'https://github.com/OpenGrok/OpenGrok/releases/tag'
    version = opengrok_version
    if version.include? 'latest'
      url = 'https://github.com/OpenGrok/OpenGrok/releases/latest'
    else
      url = "#{baseurl}/#{version}"
    end
    page = HTTParty.get(url)

    parse_page = Nokogiri::HTML(page)

    link_array = []
    parse_page.css('.release-body.commit.open').css('a').map do |a|
      link_array.push(a['href'])
    end
    tmp_link = link_array[link_array.index{|s| s.include?('tar.gz') && !s.include?('archive')}]

    if !tmp_link.include?('https://github.com')
      link = "https://github.com#{tmp_link}"
    else
      link = tmp_link
    end
  end
end

