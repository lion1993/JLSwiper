Pod::Spec.new do |s|

s.name = "JLSwiper"
s.version = "1.0.0"
s.author = "lion"
s.license = "MIT"
s.homepage = "https://github.com/lion1993/JLSwiper"
s.summary = "swiper"
s.description = "swiper"

s.source = { :git => "https://github.com/lion1993/JLSwiper.git", :tag => s.version }
s.source_files = "JLSwiper/*.{h,swift}"

s.ios.deployment_target = "10.0"
s.frameworks = "UIKit"

s.dependency "Kingfisher"

end

