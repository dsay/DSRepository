#
# Be sure to run `pod lib lint Repository.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'Repository'
    s.version          = '0.1.0'
    s.summary          = 'Essentially, provides an abstraction of data access'
    s.description      = 'The simplest approach, especially with an existing system, is to create a new Repository implementation for each business object you need to store to or retrieve from your persistence layer. Further, you should only implement the specific methods you are calling in your application. Avoid the trap of creating a “standard” repository class, base class, or default interface that you must implement for all repositories. Yes, if you need to have an Update or a Delete method, you should strive to make its interface consistent (does Delete take an ID, or does it take the object itself?), but don’t implement a Delete method on your LookupTableRepository that you’re only ever going to be calling List() on. The biggest benefit of this approach is YAGNI – you won’t waste any time implementing methods that never get called.'
    
    s.homepage         = 'https://github.com/dsay/Repository'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Dima Sai' => 'dmitriy.sai2013@gmail.com' }
    s.source           = { :git => 'https://github.com/dsay/Repository.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '10.0'
    
    s.source_files = 'Repository/Classes/**/*'
    
    s.swift_version = '4.2'
    
    s.frameworks = 'UIKit'
    
    s.dependency 'RealmSwift'
    s.dependency 'PromiseKit/CorePromise'
    s.dependency 'AlamofireImage'
    s.dependency 'ObjectMapper'
    s.dependency 'AlamofireObjectMapper'
    s.dependency 'ObjectMapper+Realm'
    s.dependency 'ObjectMapperAdditions/Realm'
end
