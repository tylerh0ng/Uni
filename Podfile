# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'wemic' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for wemic
pod 'SkyFloatingLabelTextField'
pod 'TextFieldEffects'
pod 'AIFlatSwitch'
pod 'CropViewController'
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'Firebase/Analytics'
pod 'FSPagerView'
pod 'Kingfisher', '~> 4.0'



post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

  target 'wemicTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
