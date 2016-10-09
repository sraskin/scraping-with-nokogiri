class Scrap
  require 'nokogiri'
  require 'open-uri'
  require 'rest-client'
  require 'json'

  def self.get_url
    page = Nokogiri::HTML(open('http://www.rabindra-rachanabali.nltr.org/node/2'))
    @cat_titles_link = []
    #category title
    category_type = page.css('form h2').text

    #category name & links
    category_names = page.css('form')
    category_names.each do |category_name|
      names = category_name.css('a').each do |name|
        cat_names = name.text
        cat_links = name['href']
        @cat_titles_link << {cat_links: cat_links}
      end
    end
    # @cat_titles_link.each do |title_link|
    #   title_link.each do |key, value|
    #     url = value
    #     page = Nokogiri::HTML(open("http://www.rabindra-rachanabali.nltr.org#{url}"))
    #     puts page.css('title')
    #   end
    # end
  end

  def self.uponnash
    page = Nokogiri::HTML(open('http://www.rabindra-rachanabali.nltr.org/node/6582'))
    @upo_titles_link = []
    #uponnash title
    uponnash_type = page.css('.content div h2').text

    #uponnash name & links
    uponnash_names = page.css('#content1 td')
    uponnash_names.each do |uponnash_name|
      names = uponnash_name.css('a').each do |name|
        names = name.text
        links = name['href']
        @upo_titles_link << {links: links}
      end
    end
    @upo_titles_link.each do |title_link|
      title_link.each do |key, value|
        url = value
        page = Nokogiri::HTML(open("http://www.rabindra-rachanabali.nltr.org#{url}"))
        puts story_title = page.css('#cover').text
      end
    end
  end

end