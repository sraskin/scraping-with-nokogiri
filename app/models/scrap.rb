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


  def self.cnf
    @cnf_url = []
    i=2
    page = 20
    link = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=102")
    @cnf_url << {links: link}
    begin
      links = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=102&page=#{i}")
      i +=1
      @cnf_url << {links: links}
    end until i > page
    @cnf_url.each do |key, value|
      url = key[:links].to_s
      page = Nokogiri::HTML(open("#{url}"))
      company = page.css('#main-wrapper .title').text
      address = page.css('#r1+ td').text
      city = page.css('#r2+ td').text
      country = page.css('#r3+ td').text
      telephone = page.css('#r4+ td').text
      fax = page.css('#r5+ td').text
      puts address "#{'\n'}"
    end
  end

  def self.test
    agent_ids = []
    license_nos = []
    names = []
    addresses = []
    telephones = []
    cell_phones = []
    faxes = []
    emails = []
    147.times do |n|
      page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php?&page=#{n+1}"))
      rows = page.css('tr[height="17"]')
      rows.each do |row|
        agent_id = row.css('td')[0].text
        license_no = row.css('td')[1].text
        name = row.css('td')[2].text
        address = row.css('td')[3].text
        row.search('br').each {|n| n.replace("#")}
        contact_block = row.css('td')[4].text
        telephone = contact_block.split('#')[0].gsub('Telephone: ', '').strip rescue nil
        cell_no = contact_block.split('#')[1].gsub('Cell No.: ', '').strip rescue nil
        fax = contact_block.split('#')[2].gsub('Fax: ', '').strip rescue nil
        email = contact_block.split('#')[3].gsub('Email: ', '').strip rescue nil

        agent_ids << agent_id
        license_nos << license_no
        names << name
        addresses << address
        telephones << telephone
        cell_phones << cell_no
        faxes << fax
        emails << email
        puts "======#{n} #{name}======"
      end
    end
    agent_ids.count.times do |n|
      a = Agent.create(name: names[n], address: addresses[n], phone: telephones[n], mobile: cell_phones[n], fax: faxes[n], email: emails[n], license_no: license_nos[n])
      puts "#{n} #{a.name}"
    end
  end

  def self.test_2
    page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php"))
    agents_identification_number = page.css('#inner_page_full_desc td:nth-child(2)').text
    puts agents_identification_number
  end

end

