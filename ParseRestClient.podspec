Pod::Spec.new do |s|
  s.name = 'ParseRestClient'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = 'Http RESTful client for Parse API.'
  s.homepage = 'https://github.com/acontrerasa/SwiftParseRestClient'
  s.authors = { 'Armando Contreras' => 'acontreras@clickherelabs.com' }
  s.source = { :git => 'https://github.com/arcontrerasa/SwiftParseRestClient.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ParseRestClient/*.swift'

  s.requires_arc = true
end
