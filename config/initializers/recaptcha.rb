# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  RECAPTCHA_ASKME_PUBLIC_KEY = "6Lf_UxEUAAAAAN8qXJC4A7veeHqEXdxA-1Lf7_hC"
  RECAPTCHA_ASKME_PRIVATE_KEY = "6Lf_UxEUAAAAADJjOa6G5sQsNnREmurnV-G9PIVg"
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end