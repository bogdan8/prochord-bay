require 'rails_helper'

def create_performer(user, performer)
  user.add_role :admin
  login_user_feature user
  visit new_performer_path
  within '#new_performer' do
    fill_in 'performer_title', with: performer.title
  end
  click_button I18n.t('views.global.form.add')
  expect(page).to have_content I18n.t('controllers.performers.success_create')
end

feature 'Performer' do
  let(:user) { create(:user) }
  let(:performer) { build(:performer) }

  scenario '#create' do
    create_performer(user, performer)
  end

  scenario '#edit' do
    create_performer(user, performer)
    visit edit_performer_path(id: Performer.last.slug)
    within "#edit_performer_#{Performer.last.id}" do
      fill_in 'performer_title', with: performer.title
    end
    click_button I18n.t('views.global.form.edit')
    expect(page).to have_content I18n.t('controllers.performers.success_update')
  end

  scenario '#delete' do
    create_performer(user, performer)
    accept_alert do
      click_link(Performer.last.id)
    end
    expect(page).to have_content I18n.t('controllers.performers.success_delete')
  end
end
