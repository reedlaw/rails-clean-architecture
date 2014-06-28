class EntityGenerator < Rails::Generators::NamedBase
  desc "This generator creates an entity file in lib/entities"
  source_root File.expand_path('../templates', __FILE__)

  def create_entity_file
    create_file "lib/entities/#{file_name}.rb", <<-FILE
class #{class_name} < Entity
end
    FILE
  end
end
