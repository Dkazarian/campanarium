Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :letter_opener
  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  ENV["FACEBOOK_KEY"] = "444910929014850";
  ENV["FACEBOOK_SECRET"] = "eee61e7945740ffa3f4462cb8967880f"
  ENV["TWITTER_KEY"] = "I0a4KrxdxnhHSPie5ES9mGJpJ";
  ENV["TWITTER_SECRET"] = "0c230mg9agtOAiFw5HBGaB6S0FZj4OaH3t7u5jMlam3mviAmlD"
  ENV["TWITTER_TOKEN"] = "974929477-fT7ZjR5Suih2ZV919dP2Zrbd26qDNlvyUwu1120r"
  ENV["TWITTER_TOKEN_SECRET"] = "2wdjFbcDLTafG2moy3Fx5wmu4pofMw0rvafnCHUSsrGvX"

end
