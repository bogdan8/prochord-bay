namespace :db do
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'
  desc 'Populate the table Song with songs'
  task populate: :environment do
    begin
      1.upto(3).each do |number|
        website = "https://mychords.net/zarub/page/#{number}/"
        page = Nokogiri::HTML(open(website))
        page.css('td.b-listing-singers__item__name_m a').each do |item|
          performer_url = 'https://mychords.net' + item['href']
          performer_page = Nokogiri::HTML(open(performer_url))
          performer_page_avatar = 'https://mychords.net' + (performer_page.at_css('.img-responsive').attr('data-original') ?
                                      performer_page.at_css('.img-responsive').attr('data-original') :
                                      performer_page.at_css('.img-responsive').attr('src'))
          performer_page.css('a.b-listing__item__link').each do |first|
            song_url = 'https://mychords.net' + first['href']
            song_page = Nokogiri::HTML(open(song_url))
            body = song_page.css('pre.w-words__text').text.to_s.strip
            title = if song_page.css('h1.b-title').text.to_s.strip =~ /\'/
                      song_page.css('h1.b-title').text.to_s.strip.tr!("'", '"')
                    else
                      song_page.css('h1.b-title').text.to_s.strip
                    end
            save_data performer_page_avatar, body, title
          end
        end
      end
      puts 'Done'
    rescue StandardError => error
      puts error
    end
  end

  private

  def save_data(avatar, body, title)
    performer = Performer.where(title: title.split(' - ')[0]).first_or_create!(title: title.split(' - ')[0],
                                                                               avatar: avatar)
    performer.index! if performer.save
    song = Song.where(performer_id: performer.id, title: title.split(' - ')[1])
    if song.count != 0
      puts "I'm here!"
    else
      song = performer.songs.create(title: title.split(' - ')[1],
                                    body: body,
                                    count_views: 0,
                                    active: 1,
                                    user_id: 1)
      song.index! if song.save
    end
  end
end
