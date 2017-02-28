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
    c=0
    begin
      agent = Agent.new(name: companies[c], address: addresses[c], phone: telephones[c], fax: faxs[c], city: cities[c], country: countries[c], description: descriptions[c])
      agent.save
      c +=1
    end until c > companies.count
  end

  def self.exporter_importer
    cnf_url = []
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
    cnf_url << {links: link}
    begin
      links = ("http://www.addressbazar.com/Article_Title_Body.php?Sub_Category_ID=107&page=#{i}")
      i +=1
      cnf_url << {links: links}
    end until i > page
    cnf_url.each do |key, value|
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

    c=0
    begin
      agent = Agent.new(name: companies[c], address: addresses[c], phone: telephones[c], fax: faxs[c], city: cities[c], country: countries[c], description: descriptions[c])
      begin
        agent.save
      rescue
      end
      c +=1
    end until c > companies.count
  end

  def self.bsba
    page = Nokogiri::HTML(open('http://www.bsba.org.bd/page.php?id=5'))
    table = page.css('div.wrapper table tbody')
    t=1
    begin
      tr = table.css('tr')[t]

      com_td = tr.css('td')[1]
      name_td = tr.css('td')[2]
      tel_td = tr.css('td')[3]
      company = com_td.css('p')[0].text.strip
      address = com_td.css('p')[1].text.strip
      name = name_td.css('p')[0].text.strip
      begin
        mobile = name_td.css('p')[1].text.strip
      rescue
        puts "Error"
      end
      off = tel_td.css('p')[0].text.strip
      res = tel_td.css('p')[1].text.strip
      yard = tel_td.css('p')[2].text.strip
      fax = tel_td.css('p')[3].text.strip
      phone = "#{off}, #{res}, #{yard}, #{fax},"
      puts mobile
      puts phone
      t +=1
    end until t > 147
  end

  def self.tannersbd
    page = Nokogiri::HTML(open('http://www.tannersbd.com/?page_id=759'))
    body = page.css('.entry-content')
    table = body.css('table tbody')
    tr = table.css('tr')
    tr.each_with_index do |t, index|
      unless index == 0
        td = t.css('td')
        com = td.css('td')[1]
        company = com.css('strong').text
        name = com.css('p').text
        address = td.css('td')[2].text
        member_no = td.css('td')[3].text
        product = td.css('td')[4].text
        puts "-------------------------------------------------------"
        puts "#{company}\n#{address}\n#{member_no}\n#{name}\n#{product}\n"
        puts "-------------------------------------------------------"
      end
    end
  end

  def self.bttlmea
    page = Nokogiri::HTML(open('http://www.bttlmea.com.bd/member_profile.php'))
    cat_urls = []
    company_detils_urls = []
    page.css('#content a').each do |a|
      category_url = a['href']
      cat_urls << "http://www.bttlmea.com.bd/#{category_url}"
    end
    cat_urls.each do |cat|
      cat_page = Nokogiri::HTML(open("#{cat}"))
      table = cat_page.css('table')[2]
      tr = table.css('tr')
      tr.each_with_index do |t, index|
        unless index == 0
          company_name = t.css('td')[1].text
          company_location = t.css('td')[2].text
          begin
            company_details_url = t.css('td')[3]
            div = company_details_url.css('div')
            a = div.css('a')[0]['href']
            company_detils_urls << "http://www.bttlmea.com.bd/#{a}"
          rescue
          end
        end
      end
    end
    company_detils_urls.each do |cu|
      page = Nokogiri::HTML(open("#{cu}"))
      table = page.css('td table')
      company_name = table.css('tr div')[1].text
      membership_no = table.css('tr:nth-child(3) td:nth-child(4)').text
      year_of_membership = table.css('tr:nth-child(4) td~ td+ td').text
      name = table.css('tr:nth-child(6) td:nth-child(4)').text
      position = table.css('tr:nth-child(7) td~ td+ td').text
      mobile = table.css('tr:nth-child(8) td~ td+ td').text
      email = table.css('tr:nth-child(9) td~ td+ td').text
      office_address = table.css('tr:nth-child(11) td:nth-child(4)').text
      office_phone = table.css('tr:nth-child(12) td~ td+ td').text
      office_fax = table.css('tr:nth-child(13) td~ td+ td').text
      office_email = table.css('tr:nth-child(14) td~ td+ td').text
      website = table.css('tr:nth-child(15) td~ td+ td').text
      factory_category = table.css('tr:nth-child(17) td:nth-child(4)').text
      factory_address = table.css('tr:nth-child(18) td~ td+ td').text
      factory_phone = table.css('tr:nth-child(19) td~ td+ td').text
      factory_fax = table.css('tr:nth-child(20) td~ td+ td').text
      no_of_looms = table.css('tr:nth-child(23) td:nth-child(4)').text
      loom_type = table.css('tr:nth-child(24) td~ td+ td').text
      loom_model = table.css('tr:nth-child(25) td~ td+ td').text
      production_capacity = table.css('tr:nth-child(26) td~ td+ td').text
      export_capacity = table.css('tr:nth-child(27) td~ td+ td').text
      product_spec = table.css('tr:nth-child(28) td~ td+ td').text
      no_employees = table.css('tr:nth-child(29) td~ td+ td').text
      yearly_turnover = table.css('tr:nth-child(30) td~ td+ td').text
      # puts "_____________________________________________________________________________________________________\n"
      # puts "#{company_name}\n#{membership_no}\n#{year_of_membership}\n#{name}\n#{position}\n#{mobile}\n#{email}\n
      #      #{office_address}\n#{office_phone}\n#{office_fax}\n#{office_email}\n#{website}\n#{factory_category}\n
      #      #{factory_address}\n#{factory_phone}\n#{factory_fax}\n#{no_of_looms}\n#{loom_type}\n#{loom_model}\n
      #      #{production_capacity}\n#{export_capacity}\n#{product_spec}\n#{no_employees}\n#{yearly_turnover}\n"
      # puts "_____________________________________________________________________________________________________\n"
    end
  end

  def self.haab
    urls = []
    urls << "https://www.haab-bd.com/index.php?option=com_agency&Itemid=26&lang=en"
    u=20
    begin
      urls << "https://www.haab-bd.com/index.php?option=com_agency&Itemid=26&lang=en&limitstart=#{u}"
      u +=20
    end until u > 1240
    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      table = page.css('div#inner_content table table tr')
      content = table.css('tr') #load individual agent div
      f=0
      begin
        first = content.css('tr')[f]
        table = first.css('td')[1]
        image = first.css('img')[0]['src']
        hajj_licence = table.css('td')[2].text
        agencey_name = table.css('td')[5].text
        owner_name = table.css('td')[8].text
        designation = table.css('td')[11].text
        address = table.css('td')[14].text
        phone = table.css('td')[17].text
        mobile = table.css('td')[20].text
        fax = table.css('td')[23].text
        email = table.css('td')[26].text
        website = table.css('td')[29].text
        # puts "#{image},#{hajj_licence}\n#{agencey_name}\n#{owner_name}\n#{designation}\n#{address}\n#{phone}\n#{mobile}\n#{fax}\n#{email}\n#{website}\n"
        f +=11
      end until f > 231
    end
  end

  def self.rehab
    urls = []
    details_urls = []
    u=1
    begin
      urls << "http://www.rehab-bd.org/index.php?page=members&page2=#{u}&action=Add&NumRec=&asearch="
      u +=1
    end until u > 135
    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      url_wrapper = page.css('#table_in_file table table table table table p')
      url_wrapper.each do |url|
        u = url.css('a')[0]['href']
        details_urls << "http://www.rehab-bd.org/#{u}"
      end
    end
    details_urls.each do |du|
      page = Nokogiri::HTML(open("#{du}"))
      company_name = page.css('#table_in_file span').text.strip
      type_of_company = page.css('tr:nth-child(4) td~ td+ td').text.strip
      membership_no = page.css('tr:nth-child(5) td~ td+ td').text.strip
      incorporation_date = page.css('tr:nth-child(6) td~ td+ td').text.strip
      name = page.css('tr:nth-child(9) td~ td+ td').text.strip
      designation = page.css('tr:nth-child(10) td~ td+ td').text.strip
      business_address = page.css('tr:nth-child(11) td~ td+ td').text
      phone = page.css('tr:nth-child(12) td~ td+ td').text.strip
      fax = page.css('tr:nth-child(13) td~ td+ td').text.strip
      mobile = page.css('tr:nth-child(14) td~ td+ td').text.strip
      email = page.css('tr:nth-child(15) td~ td+ td').text.strip
      web = page.css('tr:nth-child(16) td~ td+ td').text.strip
      puts "#{company_name}\n#{type_of_company}\n#{membership_no}\n#{incorporation_date}\n#{name}\n#{designation}\n
           #{business_address}\n#{phone}\n#{fax}\n#{mobile}\n#{email}\n#{web}\n"
    end
  end

  def self.toab
    urls = []
    u=1
    begin
      urls << "http://www.toab.org/detail_member.php?idn=#{u}"
      u +=1
    end until u > 317
    page = Nokogiri::HTML(open('http://www.toab.org/detail_member.php?idn=1'))
    wrapper = page.css('td table')
    company = wrapper.css('.body_text_dark_blue strong').text
    tr = wrapper.css('tr+ tr .body_text_dark_blue').text
    a = tr.split("\r")
    name = a.slice!(0)
    address = a.join('').strip
    phone = wrapper.css('tr:nth-child(3) td').text.strip
    mobile = wrapper.css('tr:nth-child(4) td').text.strip
    email = wrapper.css('tr:nth-child(5) td').text.strip
    website = wrapper.css('tr:nth-child(6) td').text.strip
  end

  def self.bmss
    urls = []
    u=1
    begin
      urls << "http://www.bmss-bd.org/member-directory.php?CurLst=#{u}&"
      u +=1
    end until u > 37
    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      wrapper = page.css('div.about-content div.paragraph-row')
      f_div = wrapper.css('.paragraph-row')
      f_div.each do |f|
        s_div = f.css('.column16')
        s_div.each do |s|
          t_div = s.css('.bmss-member')
          f_div = t_div.css('div')[2]
          company = f_div.css('h3').text
          n = f_div.css('p')[0].text.gsub('Name:', '')
          name = n.gsub(':', '').strip
          a = f_div.css('p')[1].text.gsub('Address', '')
          address = a.gsub(':', '').strip
          p = f_div.css('p')[2].text.gsub('Contact', '')
          phone = p.gsub(':', '').strip
          e = f_div.css('p')[3].text.gsub('Email', '')
          email = e.gsub(':', '').strip
          m = f_div.css('p')[4].text.gsub('Membership Number', '')
          membership = m.gsub(':', '').strip
          puts company
        end
      end
    end
  end

  def self.bkmea
    urls = []
    details_urls = []

    urls << "http://www.bkmea.com/member/index.php?Index=all"
    u=2
    begin
      urls << "http://www.bkmea.com/member/index.php?Index=all&page=#{u}"
      u +=1
    end until u > 94

    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      wrapper = page.css('table table')
      body = wrapper.css('tr')[6]
      table = body.css('table tr')
      table.each_with_index do |t, index|
        unless index == 0
          td = t.css('td')[0]
          url = td.css('a')[0]['href'].gsub('./', 'http://www.bkmea.com/member/')
          details_urls << url
          puts url
        end
      end
    end
    details_urls.each do |d|
      page = Nokogiri::HTML(open("#{d}"))
      table = page.css('table table')
      membership = table.css('#option+ #tbl .normal:nth-child(3) td+ td').text
      membership_type = table.css('#option+ #tbl .normal:nth-child(4) td+ td').text
      year_of_reg = table.css('#option+ #tbl .normal:nth-child(5) td+ td').text
      no_of_worker = table.css('tr:nth-child(4) .normal:nth-child(5) td+ td').text
      address_factory = table.css('.value:nth-child(3)').text
      address_office = table.css('.value:nth-child(10)').text
      company = table.css('#option+ #tbl .normal:nth-child(2) td+ td').text
      background_info = "Membership No:\n#{membership}\nMembership Type:\n#{membership_type}\nYear of Reg.:\n#{year_of_reg}\nNo of Worker:\n#{no_of_worker}"
      name = table.css('tr:nth-child(3) .normal:nth-child(2) td+ td').text
      mobile = table.css('tr:nth-child(3) .normal:nth-child(3) td+ td').text
      role = table.css('tr:nth-child(3) .normal:nth-child(4) td+ td').text
      address = "Factory: \n#{address_factory}\nOffice: #{address_office}"
      phone = table.css('.value:nth-child(5)').text
      email = table.css('.value:nth-child(16)').text
    end
  end

  def self.baffa
    urls = []
    urls << "http://www.baffa-bd.org/members.php"
    u=2
    begin
      urls << "http://www.baffa-bd.org/members.php?page=#{u}"
      u +=1
    end until u > 96
    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      wrapper = page.css('table table table table')
      table = wrapper.css('td table') #iterate1
      table.each do |t|
        com_tr = t.css('tr')[0]
        add_tr = t.css('tr')[1]
        call_tr = t.css('tr')[2]
        web_tr = t.css('tr')[4]
        name_td = t.css('tr')[5]
        role_td = t.css('tr')[6]
        company = com_tr.css('td')[0].text
        member = com_tr.css('td')[1].text
        address = add_tr.css('td')[0].text
        phone = call_tr.css('td')[0].text.gsub('Tel:', '').strip
        mobile = call_tr.css('td')[1].text.gsub('Cell:', '').strip
        email = web_tr.css('td')[0].text.gsub('Email:', '').strip
        website = web_tr.css('td')[1].text.gsub('Web:', '').strip
        name = name_td.css('td')[0].text.gsub('PTC:', '').strip
        role = role_td.css('td')[0].text
        puts company
      end
    end
  end

  def self.basis
    urls = []
    details_urls = []
    urls << "http://www.basis.org.bd/index.php/members_area/member_list"
    u=20
    begin
      urls << "http://www.basis.org.bd/index.php/members_area/member_list/#{u}"
      u +=20
    end until u > 1040
    urls.each do |u|
      page = Nokogiri::HTML(open("#{u}"))
      wrapper= page.css('.border+ td , b')
      table = wrapper.css('td table')
      table.each do |t|
        tr = t.css('tr')[0]
        url = tr.css('a')[0]['href']
        details_urls << url
        puts url
      end
    end
    details_urls.each do |d|
      page = Nokogiri::HTML(open("#{d}"))

      membership = page.css('td td td td tr:nth-child(1) tr:nth-child(5) font').text
      estiblished = page.css('td td td td tr:nth-child(1) tr:nth-child(6) font').text
      other_site = page.css('td td td td tr:nth-child(1) tr:nth-child(6) font').text
      email_o = page.css('td td td td td tr:nth-child(9) .bodytext+ .bodytext font').text
      email_t = page.css('tr:nth-child(15) .bodytext+ .bodytext font').text
      ph_two = page.css('tr:nth-child(14) .bodytext+ .bodytext font').text
      ph_one = page.css('td td td td tr:nth-child(1) tr:nth-child(8) .bodytext+ .bodytext font').text

      company = page.css('td td td td tr:nth-child(1) tr:nth-child(4) .bodytext+ .bodytext font').text
      address = page.css('td td td td td tr:nth-child(7) .bodytext+ .bodytext font').text
      phone = "#{ph_one}, #{ph_two}"
      website = page.css('tr:nth-child(9) .bodytext+ .bodytext font').text
      name = page.css('td td td td td tr:nth-child(13) .bodytext+ .bodytext font').text
      role = page.css('tr:nth-child(13) .bodytext+ .bodytext font').text
      email = "#{email_o}\n#{email_t}"
      background_info = "#{membership}\n#{estiblished}\n#{other_site}"
      puts "#{company}\n#{address}\n#{phone}\n#{email}\n#{name}\n#{role}"
    end
  end

  def self.baira
    page = Nokogiri::HTML(open('http://www.baira.org.bd/extra/withoutphoto.php'))
    wrapper = page.css('table tr')
    wrapper.each_with_index do |w, index|
      unless index == 0
        name = w.css('td')[1].text
        role = w.css('td')[2].text
        company = w.css('td')[3].text
        reg_no = w.css('td')[4].text
        address = w.css('td')[5].text
        phone = w.css('td')[6].text.gsub('(Off.)', '').gsub('(Res.)', '').gsub('(Off)', '').gsub('Off.)', '').strip
        mobile = w.css('td')[7].text
        email = w.css('td')[9].text
      end
    end
  end

end


