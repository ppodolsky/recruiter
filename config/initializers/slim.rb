  Slim::Embedded.default_options[:markdown] = {:auto_ids => false}
  Slim::Engine.set_default_options :shortcut => {'&' => {:tag => 'input', :attr => 'type'}, '#' => {:attr => 'id'}, '.' => {:attr => 'class'}}
