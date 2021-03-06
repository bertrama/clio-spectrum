set :rails_env, 'na_dev'
set :application, 'new_arrivals_dev'
set :domain,      'rowling.cul.columbia.edu'
set :deploy_to,   "/opt/passenger/#{application}/"
set :user, 'deployer'
set :branch, @variables[:branch] || 'na_dev'
set :scm_passphrase, 'Current user can full owner domains.'

role :app, domain
role :web, domain
role :db,  domain, primary: true
