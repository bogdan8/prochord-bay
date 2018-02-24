require 'rails_helper'

def create_song(user, song)
  user.add_role :admin
  login_user_feature user
  visit new_song_path
  within '#new_song' do
    fill_in 'song_title', with: song.title
    fill_in 'song_body', with: song.body
  end
  click_button I18n.t('views.global.form.add')
  expect(page).to have_content I18n.t('controllers.songs.success_create')
end

feature 'Songs' do
  let(:user) { create(:user) }
  let(:performer) { create(:performer) }
  let(:song) { build(:song) }

  scenario '#create' do
    performer.save
    create_song(user, song)
  end

  scenario '#edit' do
    create_song(user, song)
    visit edit_song_path(id: Song.last.slug)
    within "#edit_song_#{Song.last.id}" do
      fill_in 'song_title', with: 'this will be new title'
    end
    click_button I18n.t('views.global.form.edit')
    expect(page).to have_content I18n.t('controllers.songs.success_update')
  end

  scenario '#delete' do
    create_song(user, song)
    accept_alert do
      click_link(Song.last.id)
    end
    expect(page).to have_content I18n.t('controllers.songs.success_delete')
  end
end
