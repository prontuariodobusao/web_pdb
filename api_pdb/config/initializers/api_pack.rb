Rails.application.config.to_prepare do
  ApiPack.hmac_secret = ENV['HMAC_SECRET']
end
