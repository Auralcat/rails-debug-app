# frozen_string_literal: true
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'rails', '6.0.0'
  gem 'sqlite3'
end

require 'active_record/railtie'
require 'active_storage/engine'
require 'logger'

class TestApp < Rails::Application
  config.root = __dir__
  config.hosts << 'example.org'
  config.session_store :cookie_store, key: 'cookie_store_key'
  config.eager_load = false
  secrets.secret_key_base = 'secret_key_base'

  Rails.logger = config.logger = Logger.new($stdout)
end

ENV['DATABASE_URL'] = 'sqlite3::memory:'

Rails.application.initialize!

ActiveRecord::Schema.define do
  require ActiveStorage::Engine.root.join('db/migrate/20170806125915_create_active_storage_tables.rb').to_s
  CreateActiveStorageTables.new.change

  create_table :users, force: true do |t|
  end
end

class User < ActiveRecord::Base
  has_one_attached :avatar
end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_attach_and_detach
    user = ::User.new
    user.avatar.attach(
      content_type: 'text/plain',
      filename: 'avatar.txt',
      io: ::StringIO.new,
    )
    user.avatar.detach
    user.save!
  end
end

