class UserMailer < Devise::Mailer
  default from: 'prochord.mil'

  layout 'mailer'

  def send_password_to_user(user, password)
    @user = user
    @user_password = password
    mail(to: @user.email, subject: 'Ваш тимчасовий пароль.')
  end

  def send_add_song(user, song)
    @user = user
    @song = song
    mail(to: @user.email, subject: 'Публікація пісні.')
  end

  def send_add_song_active(user, song)
    @user = user
    @song = song
    mail(to: @user.email, subject: 'Публікація пісні.')
  end
end
