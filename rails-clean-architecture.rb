gem 'hashie'
gem 'pg'
gem 'tilt'
gem 'tilt-handlebars'
gem 'unicorn'

gem_group :development, :test do
  gem 'byebug'
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
    end
CODE

# Remove assets/views
run 'rm -r app/assets app/models app/views lib/assets'

def source_paths
  Array(super) + 
    [File.join(File.expand_path(File.dirname(__FILE__)),'rails_root')]
end

inside 'lib' do
  inside 'entities' do
    copy_file 'entity.rb'
  end
  inside 'generators' do
    inside 'entity' do
      copy_file 'entity_generator.rb'
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
end
