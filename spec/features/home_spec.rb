require 'rails_helper'

feature 'Home page' do
  scenario '#send search form with parameter' do
    visit root_path locale: :en
    within '#search_form' do
      fill_in 'search', with: 'test'
    end
    click_button 'Search'
    expect(page).to have_content 'Search result'
  end
end
