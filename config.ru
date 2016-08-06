# Loading an environment
require_relative './config/environment'
# When I use tux:
# require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Starting Application
use Rack::MethodOverride
use ReviewController
use CriticController
run ApplicationController
