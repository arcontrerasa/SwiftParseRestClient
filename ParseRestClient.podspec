Pod::Spec.new do |s|
  s.name = 'ParseRestClient'
  s.version = '0.0.3'
  s.license      =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'HTTP RESTful client for Parse API.'
  s.homepage = 'https://github.com/arcontrerasa/SwiftParseRestClient'
  s.authors = { 'Armando Contreras' => 'acontreras@clickherelabs.com' }
  s.source = { :git => 'https://github.com/arcontrerasa/SwiftParseRestClient.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'ParseRestClient/*.swift'

  s.requires_arc = true
end
