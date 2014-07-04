class InteractorGenerator < Rails::Generators::NamedBase
  desc "This generator creates an interactor file in lib/interactors"
  source_root File.expand_path('../templates', __FILE__)

  def create_interactor_file
    create_file "lib/interactors/#{file_name}.rb", <<-FILE
class #{class_name} < Interactor
  def call
    raise UnauthorizedAccess if not authorized?
    super
  end

  def authorized?
    # TODO: define method for permission to call this interactor
  end
end
    FILE

    create_file "spec/interactors/#{file_name}_spec.rb", <<-FILE
require 'interactors/interactor.rb'
require 'interactors/#{file_name}.rb'
require 'spec_helper.rb'

describe #{class_name} do

  it_behaves_like 'an interactor'

end
    FILE
  end
end
