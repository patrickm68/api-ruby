# frozen_string_literal: true

source "https://rubygems.org"

gem "securerandom"
gem "oj"

gem "sorbet-runtime"
gem "openssl"
gem "zeitwerk", "~> 2.5"

group :development do
  gem "sorbet"
  gem "tapioca"

  gem "rake"

  gem "rubocop", require: false
  gem "rubocop-shopify", require: false
  gem "rubocop-sorbet", require: false
end

group :test do
  gem "minitest"
  gem "fakefs", require: false
end
