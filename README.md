# Prochord

### run project:
- 1: `rake db:setup`
- 2: `rake sunspot:solr:start`
- 3: `rake sunspot:solr:reindex`
- 4: `rake db:populate`
- 5: `rake db:songs_index`
- 6:  new window run: `sidekiq -q sunspot`

#### users:
> - admin: email: `admin@admin.com`, password: `123456`
> - user: email: `user@user.com`, password: `123456`