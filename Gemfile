source "https://rubygems.org"

ruby "3.3.8"

# Core Rails
gem "rails", "~> 7.1.5", ">= 7.1.5.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"

# Asset pipeline & frontend tooling
gem "importmap-rails"
gem "turbo-rails"             # Hotwire's SPA-like page accelerator
gem "stimulus-rails"          # Hotwire's modest JavaScript framework
gem "tailwindcss-rails"
gem "sprockets-rails"

# JSON & API helpers
gem "jbuilder"

# Authentication
gem "devise", "~> 4.9"

# Geolocation and data
gem "geocoder", "~> 1.8"
gem "countries"

# Tagging
gem "acts-as-taggable-on"

# Friendly URLs
gem "friendly_id"

# Tooling
gem "annotate", "~> 3.2"
gem "bootsnap", require: false

# Windows-specific
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Optional / commented
# gem "redis", ">= 4.0.1"
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
# gem "image_processing", "~> 1.2"
# gem "spring"
# gem "rack-mini-profiler"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "pry-rails", "~> 0.3.11"
end

group :development do
  gem "web-console"
end
