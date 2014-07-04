class EntityGenerator < Rails::Generators::NamedBase
  desc "This generator creates an entity file in lib/entities"
  source_root File.expand_path('../templates', __FILE__)

  def create_entity_file
    create_file "lib/entities/#{file_name}.rb", <<-FILE
class #{class_name} < Entity
end
    FILE

    create_file "spec/entities/#{file_name}_spec.rb", <<-FILE
require 'entities/entity.rb'
require 'entities/#{file_name}.rb'
require 'spec_helper.rb'

describe #{class_name} do

  it_behaves_like 'an entity'

end
    FILE
  end
end
