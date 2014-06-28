gem 'hashie'
gem 'unicorn'

gem_group :development, :test do
  gem 'byebug'
end

gsub_file "Gemfile", /^gem\s+["']sqlite3["'].*\n/, ''
gsub_file "Gemfile", /^gem\s+["']jbuilder["'].*\n/, ''
gsub_file "Gemfile", /^gem\s+["']sdoc["'].*\n/, ''
gsub_file "Gemfile", /^#.*\n/, ''
gsub_file "Gemfile", /^$\n/, ''
gsub_file "Gemfile", /"/, '\''

# Remove assets/views
run "rm -r app/assets app/models app/views lib/assets"

def source_paths
  Array(super) + 
    [File.join(File.expand_path(File.dirname(__FILE__)),'rails_root')]
end

inside 'lib' do
  inside 'entities' do
    copy_file 'entity.rb'
  end
end

inside 'lib' do
  inside 'interactors' do
    copy_file 'interactor.rb'
  end
end

inside 'lib' do
  copy_file 'request.rb'
end

inside 'lib' do
  copy_file 'response.rb'
end

inside 'spec' do
  copy_file 'spec_helper.rb'
end
