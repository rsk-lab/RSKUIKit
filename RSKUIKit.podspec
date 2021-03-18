Pod::Spec.new do |s|
  s.name          = 'RSKUIKit'
  s.version       = '1.1.0'
  s.summary       = 'An addition to the UIKit framework.'
  s.description   = <<-DESC
                   An addition to the UIKit framework. RSKUIKit provides: a) protocols that define the roles of objects, b) the type of object that represents bounds of the view, c) the type of object that represents a frame of the view, d) the type of object that converts layout attributes of the view from `.leftToRight` user interface layout direction to the specified one, e) the type of object that represents changes to a collection of views.
                   DESC
  s.homepage      = 'https://github.com/rsk-lab/RSKUIKit'
  s.license      = { :type => 'RPL-1.5 / R.SK Lab Professional', :file => 'COPYRIGHT.md' }
  s.authors       = { 'Ruslan Skorb' => 'ruslan@rsk-lab.com' }
  s.source        = { :git => 'https://github.com/rsk-lab/RSKUIKit.git', :tag => s.version.to_s }
  s.platform      = :ios, '10.0'
  s.swift_version = '5.3'
  s.source_files  = 'RSKUIKit/*.{h,swift}'
  s.requires_arc  = true
  s.dependency 'RSKCoreGraphics', '1.1.0'
end
