namespace :db do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  desc 'Populate the table Song with songs'
  task populate: :environment do
    8.upto(15).each do |number|
      website = "https://mychords.net/zarub/page/#{number}/"
      page = Nokogiri::HTML(open(website))
      page.css('td.b-listing-singers__item__name_m a').each do |item|
        performer_url = 'https://mychords.net' + item['href']
        performer_page = Nokogiri::HTML(open(performer_url))
        performer_page_image = 'https://mychords.net' + performer_page.at_css('.img-responsive').attr('data-original')
        performer_page.css('a.b-listing__item__link').each do |first|
          song_url = 'https://mychords.net' + first['href']
          song_page = Nokogiri::HTML(open(song_url))
          body = song_page.css('pre.w-words__text').text.to_s.strip
          if song_page.css('h1.b-title').text.to_s.strip =~ /\'/
            title = song_page.css('h1.b-title').text.to_s.strip.tr!("'", '"')
          else
            title = song_page.css('h1.b-title').text.to_s.strip
          end
          vari = Song.where(performer: title.split(' - ')[0], title: title.split(' - ')[1])
          if vari.count != 0
            puts "I'm here!"
          else
            song = Song.create(performer: title.split(' - ')[0],
                               title: title.split(' - ')[1],
                               body: body,
                               count_views: 0,
                               avatar: performer_page_image,
                               active: 1,
                               user_id: 1)
            song.index! if song.save
          end
        end
      end
    end
    puts 'Done'
  end
end
