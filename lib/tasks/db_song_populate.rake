namespace :db do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  desc 'Populate the table Song with songs'
  task populate: :environment do
    10.upto(41).each do |number|
      website = "http://hm6.ru/nashi/page/#{number}/"
      page = Nokogiri::HTML(open(website))
      page.css('td.b-listing-singers__item__name_m a').each do |item|
        website_first =  'http://hm6.ru' + item['href']
        page_first = Nokogiri::HTML(open(website_first))
        page_first.css('a.b-listing__item__link').each do |first|
          website_second = 'http://hm6.ru' + first['href']
          page_second = Nokogiri::HTML(open(website_second))
          body = page_second.css('pre.w-words__text').text.to_s.strip
          if page_second.css('h1.b-title').text.to_s.strip =~ /\'/
            title = page_second.css('h1.b-title').text.to_s.strip.gsub!("'", "\"")
          else
            title = page_second.css('h1.b-title').text.to_s.strip
          end
          vari = Song.where(performer: title.split(' - ')[0], title: title.split(' - ')[1])
          if vari.count != 0
            puts "I'm here!"
          else
            song = Song.create(performer: title.split(' - ')[0], title: title.split(' - ')[1], body: body, count_views: 0, active: 1, user_id: 1)
            song.index!
          end
        end
      end
    end
  end
end