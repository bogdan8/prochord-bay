# Prochord

## install solr:
- 1: `cd /opt`
- 2: `wget http://archive.apache.org/dist/lucene/solr/6.6.2/solr-6.6.2.tgz`
- 3: `tar xzf solr-6.6.2.tgz solr-6.6.2/bin/install_solr_service.sh --strip-components=2`
- 4: `sudo ./install_solr_service.sh solr-6.6.2.tgz`
  #### create new collection
  - 1: `su - solr -c "/opt/solr/bin/solr create -c development -n data_driven_schema_configs"`
  #### setting collection
  - 1: `cd /var/solr/data/development/conf`
  - 2: `rm solrconfig.xml`
  - 3: `wget https://raw.githubusercontent.com/sunspot/sunspot/master/sunspot_solr/solr/solr/configsets/sunspot/conf/schema.xml`
  - 4: `wget https://raw.githubusercontent.com/sunspot/sunspot/master/sunspot_solr/solr/solr/configsets/sunspot/conf/solrconfig.xml`
  - 5: `sudo service solr restart`

## setting sunspot
  - 1: `rake sunspot-solr start -p 8983`
  - 2: `rake sunspot:reindex`

## run project:
- 1: `rake db:setup`
- 2: `rake sunspot:solr:start`
- 3: `rake sunspot:solr:reindexs`
- 4: `rake db:populate`
- 5: `rake db:songs_index`
- 6:  new window run: `sidekiq -q sunspot`

### users:
> - admin: email: `admin@admin.com`, password: `123456`
> - user: email: `user@user.com`, password: `123456`