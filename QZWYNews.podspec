
  Pod::Spec.new do |s|
  s.name         = "QZWYNews"
  s.version      = "0.0.1"
  s.summary      = "A short description of QZWYNews."
  s.homepage     = "http://EXAMPLE/QZWYNews"
  s.license      = "MIT (example)"
  s.author             = { "" => "" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "http://EXAMPLE/QZWYNews.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true

end
