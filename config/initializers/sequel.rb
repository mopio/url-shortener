require 'pg'
require 'sequel'

Sequel.single_threaded = true
Sequel.connect ENV['DATABASE_URL'] ||
  "postgres://localhost/url_shortener_#{App.env}"
