require 'rails_helper'

RSpec.describe Devise::Mailer do
  it '#sends a confirmation email to correct email with custom text' do
    user = create(:user, email: 'prochord@gmail.com', confirmed_at: '')

    confirmation_email = Devise.mailer.deliveries.last

    expect(user.email).to eq(confirmation_email.to[0])
    expect(confirmation_email.body.to_s).to have_content user.email
  end
end
