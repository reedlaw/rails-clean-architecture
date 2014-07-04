require 'active_model'

class Entity
  include ActiveModel::Validations
  attr_accessor :id

  def initialize(attr = {})
    attr.each do |name, value|
      send("#{name}=", value)
    end
  end
end
