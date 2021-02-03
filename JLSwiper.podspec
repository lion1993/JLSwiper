

Pod::Spec.new do |spec|

  spec.name         = "JLSwiper"

  spec.version      = "1.0.0"

  spec.summary      = "A short description of JLSwiper."

  spec.description  = "swiper"

  spec.homepage     = "http://github.com/lion1993/JLSwiper"

  spec.license      = "MIT"

  spec.author       = { "吕晶晶" => "1160861008@qq.com" }

  spec.source  = { :git => "http://github.com/lion1993/JLSwiper.git", :tag => "#{spec.version}" }

  spec.source_files  = "JLSwiper/**/*.{h,m,swift}"

  spec.dependency "Kingfisher"

end
