$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'wip-checklist'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require(f) }

RSpec.configure do |config|
  config.include Support
end
