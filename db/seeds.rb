unless User.with_any_role(:admin).any?
  admin = User.new
  admin.email = 'bogdanlitvin8@gmail.com'
  admin.password = '70sunogo'
  admin.confirmed_at = '2016-07-17 07:35:55.139051'
  admin.confirmation_sent_at = '2016-07-17 07:35:36.292019'
  admin.save
  admin.add_role 'admin'
  puts "Адміністратора добавлено, email(admin@admin.com), password(123456)"
  # add user
  user = User.new
  user.email = 'user@user.com'
  user.name = 'Bobo'
  user.password = '123456'
  user.confirmed_at = '2016-07-17 07:35:55.139051'
  user.confirmation_sent_at = '2016-07-17 07:35:36.292019'
  user.save
  user.add_role 'user'
  puts "Користувача добавлено, email(user@user.com), password(123456)"
end