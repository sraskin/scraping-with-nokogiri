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


  def self.test_4
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
        row.search('br').each { |n| n.replace("#") }
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

  def self.test_6
    page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php"))
    agents_identification_number = page.css('#inner_page_full_desc td:nth-child(2)').text
    puts agents_identification_number
  end

  def self.exporter_importer_2
    @exporter_url = []
    i=2
    page = 97
    link = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=107")
    @exporter_url << {links: link}
    begin
      links = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=107&page=#{i}")
      i +=1
      @exporter_url << {links: links}
    end until i > page
    comp = []
    @exporter_url.each do |key, value|
      url = key[:links].to_s
      page = Nokogiri::HTML(open("#{url}"))
      company = page.css('#main-wrapper .title').text
      address = page.css('#r1+ td').text
      city = page.css('#r2+ td').text
      country = page.css('#r3+ td').text
      telephone = page.css('#r4+ td').text
      fax = page.css('#r5+ td').text
      description = page.css('#r6+ td').text
      comp << company
      comp.each do |c|
        puts "#{c}\n"
      end
    end
  end

  def self.ctg_cnf
    @ctg_url = []
    i=2
    page = 147
    link = ("http://chc.gov.bd/imp/cnf_agents.php")
    @ctg_url << {links: link}
    begin
      links = ("http://chc.gov.bd/imp/cnf_agents.php?&page=#{i}")
      i +=1
      @ctg_url << {links: links}
    end until i > page
    @ctg_url.each do |key, value|
      url = key[:links].to_s
      page = Nokogiri::HTML(open("#{url}"))
      agents_identification_number = page.css('#inner_page_full_desc td:nth-child(2)').text
      puts agents_identification_number
    end
  end

  def self.test
    page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php"))
    i = 2
    s = 14
    id = []
    begin
      agents_identification_number = page.css("#inner_page_full_desc tr:nth-child(#{i}) td:nth-child(1)").text
      i +=1
      id << agents_identification_number
    end until i > s
    id.each do |ii|
      puts ii
    end
  end

  def self.test_2
    page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php"))
    agents_identification_number = page.css("tr:nth-child(2) td:nth-child(5)").text
    puts agents_identification_number
  end

  def self.test_3
    agent_ids = []
    license_nos = []
    names = []
    addresses = []
    telephones = []
    cell_phones = []
    faxes = []
    emails = []
    page = Nokogiri::HTML(open("http://chc.gov.bd/imp/cnf_agents.php"))
    rows = page.css('tr[height="17"]')
    rows.each do |row|
      agent_id = row.css('td')[0].text
      license_no = row.css('td')[1].text
      name = row.css('td')[2].text
      address = row.css('td')[3].text
      contact_block = row.css('td')[4]
      telephone = contact_block.css("br")[0].text
      cell_no = contact_block.css("br")[1].text
      fax = contact_block.css("br")[2].text
      email = contact_block.css("br")[3].text

      agent_ids << agent_id
      license_nos << license_no
      names << name
      addresses << address
      telephones << telephone
      cell_phones << cell_no
      faxes << fax
      emails << email
    end
  end

  def self.address_bazar
    page = Nokogiri::HTML(open("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=102"))
    page.css("th:contains('Company')").each do |name|
      company_name = name.parent.css("th")[1].text
      puts company_name
    end
  end

  def self.cnf
    @cnf_url = []
    companies = []
    addresses = []
    cities = []
    countries = []
    telephones = []
    faxs = []
    descriptions = []
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
      page.css("th:contains('Company')").each do |name|
        company_name = name.parent.css("th")[1].text
        companies << company_name
      end
      page.css("th:contains('Address')").each do |add|
        address = add.parent.css("td").text
        addresses << address
      end
      page.css("th:contains('City')").each do |city|
        city = city.parent.css("td").text
        cities << city
      end
      page.css("th:contains('Country')").each do |country|
        country = country.parent.css("td").text
        countries << country
      end
      page.css("th:contains('Telephone')").each do |telephone|
        telephone = telephone.parent.css("td").text
        telephones << telephone
      end
      page.css("th:contains('Fax')").each do |fax|
        fax = fax.parent.css("td").text
        faxs << fax
      end
      page.css("th:contains('Description')").each do |description|
        description = description.parent.css("td").text
        descriptions << description
      end
    end
  end

  def self.exporter_importer
    @cnf_url = []
    companies = []
    addresses = []
    cities = []
    countries = []
    telephones = []
    faxs = []
    descriptions = []
    i=2
    page = 97
    link = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=107")
    @cnf_url << {links: link}
    begin
      links = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=107&page=#{i}")
      i +=1
      @cnf_url << {links: links}
    end until i > page
    @cnf_url.each do |key, value|
      url = key[:links].to_s
      page = Nokogiri::HTML(open("#{url}"))
      page.css("th:contains('Company')").each do |name|
        company_name = name.parent.css("th")[1].text
        companies << company_name
      end
      page.css("th:contains('Address')").each do |add|
        address = add.parent.css("td").text
        addresses << address
      end
      page.css("th:contains('City')").each do |city|
        city = city.parent.css("td").text
        cities << city
      end
      page.css("th:contains('Country')").each do |country|
        country = country.parent.css("td").text
        countries << country
      end
      page.css("th:contains('Telephone')").each do |telephone|
        telephone = telephone.parent.css("td").text
        telephones << telephone
      end
      page.css("th:contains('Fax')").each do |fax|
        fax = fax.parent.css("td").text
        faxs << fax
      end
      page.css("th:contains('Description')").each do |description|
        description = description.parent.css("td").text
        descriptions << description
      end
    end
    puts companies.count
    puts addresses.count
    puts cities.count
    puts countries.count
    puts telephones.count
    puts faxs.count
    puts descriptions.count
  end
end

