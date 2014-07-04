gem 'hashie'
gem 'pg'
gem 'tilt'
gem 'tilt-handlebars'
gem 'unicorn'

gem_group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
end

gsub_file 'Gemfile', /^gem\s+["']sqlite3["'].*\n/, ''
gsub_file 'Gemfile', /^gem\s+["']jbuilder["'].*\n/, ''
gsub_file 'Gemfile', /^gem\s+["']sdoc["'].*\n/, ''
gsub_file 'Gemfile', /^#.*\n/, ''
gsub_file 'Gemfile', /^$\n/, ''
gsub_file 'Gemfile', /"/, '\''

environment <<-CODE
config.generators do |g|
      g.orm             :active_record
      g.stylesheets     false
      g.javascripts     false
      g.controller      :clean_controller
      g.view_specs false
      g.helper_specs false
    end
CODE

# Remove assets/views
run 'rm -r app/assets app/models app/views lib/assets'

def source_paths
  Array(super) + 
    [File.join(File.expand_path(File.dirname(__FILE__)),'rails_root')]
end

remove_file '.gitignore'
copy_file '.gitignore'

inside 'config' do
  remove_file 'database.yml'
  template 'database.example.yml'
  run "ln -s database.example.yml database.yml"
end

inside 'lib' do
  inside 'entities' do
    copy_file 'entity.rb'
  end
  inside 'generators' do
    inside 'entity' do
      copy_file 'entity_generator.rb'
    end
    inside 'interactor' do
      copy_file 'interactor_generator.rb'
    end
  end
  inside 'interactors' do
    copy_file 'interactor.rb'
  end
  copy_file 'request.rb'
  copy_file 'response.rb'
  inside 'templates' do
    inside 'rails' do
      inside 'controller' do
        copy_file 'controller.rb'
      end
    end
  end
end

inside 'spec' do
  copy_file 'spec_helper.rb'
  inside 'support' do
    copy_file 'entity_shared_examples.rb'
    copy_file 'interactor_shared_examples.rb'
  end
end

puts
puts 'Clean Architecture Rails app generated!'
puts
puts 'Now you should:'
puts
puts '1. cd ' + @app_name
puts '2. bundle'
puts '3. Check config/database.yml'
puts '4. Generate entities with "rails generate entity *name*"'
puts '7. Generate interactors with "rails generate interactor *name*"'
puts '8. Add tests and production code and test with rspec'
puts '9. Add routes, controller actions, and handlebars templates'
