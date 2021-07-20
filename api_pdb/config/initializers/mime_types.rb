# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register 'application/json', :json, %w[text/x-json application/jsonrequest]
Mime::Type.register 'multipart/form-data', :multipart_form
Mime::Type.register 'application/x-www-form-urlencoded', :url_encoded_form
