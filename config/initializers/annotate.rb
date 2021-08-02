if Rails.env.development?
  require 'annotate'
  
  Annotate.set_defaults(
    'models' => 'true',
    'position' => 'top',
    'exclude_tests' => 'true',
    'exclude_fixtures' => 'true',
    'exclude_factories' => 'true',
    'exclude_serializers' => 'true',
  )
  
end
