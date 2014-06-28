require 'tilt/handlebars'

<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Controller < ApplicationController
<% actions.each do |action| -%>
  def <%= action %>
    template = Tilt.new('app/views/<%= file_name %>/<%= action %>.html.hbs')
    render text: template.render
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>
