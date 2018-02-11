require 'rails_helper'

feature 'Home page' do
  scenario '#send search form with parameter' do
    visit root_path
    within '#search_form' do
      fill_in 'search', with: 'test'
    end
    click_button I18n.t('views.home.search')
    expect(page).to have_content I18n.t('views.home.search_results')
  end
end
