# Load the rails application
require File.expand_path('../application', __FILE__)

SHA512_PATTERN = /[0-9a-f]{128}/

# Initialize the rails application
Nodemap::Application.initialize!

