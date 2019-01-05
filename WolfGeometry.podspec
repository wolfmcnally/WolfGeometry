Pod::Spec.new do |s|
    s.name             = 'WolfGeometry'
    s.version          = '3.0.1'
    s.summary          = 'Swift methods, types, and extensions for doing geometrical calculations.'

    s.homepage         = 'https://github.com/wolfmcnally/WolfGeometry'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Wolf McNally' => 'wolf@wolfmcnally.com' }
    s.source           = { :git => 'https://github.com/wolfmcnally/WolfGeometry.git', :tag => s.version.to_s }

    s.source_files = 'WolfGeometry/Classes/**/*'

    s.swift_version = '4.2'

    s.ios.deployment_target = '9.3'
    s.macos.deployment_target = '10.13'
    s.tvos.deployment_target = '11.0'

    s.module_name = 'WolfGeometry'

    s.dependency 'ExtensibleEnumeratedName'
    s.dependency 'WolfNumerics'
    s.dependency 'WolfStrings'
    s.dependency 'WolfFoundation'
end
