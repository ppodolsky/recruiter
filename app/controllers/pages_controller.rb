class PagesController < InheritedResources::Base
  include HighVoltage::StaticPage

  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
end
