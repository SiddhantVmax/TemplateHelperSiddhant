

Pod::Spec.new do |spec|

  

  spec.name         = "TemplateHelperSiddhant"
  spec.version      = "0.0.9"
  spec.summary      = "siddhant demo frame work for something good yo it will be good"

  
  spec.description  = "siddhant demo frame work for something good yo it will be good warmane lovers"

  spec.homepage     = "https://github.com/SiddhantVmax/TemplateHelperSiddhant"
  



  spec.license      = "MIT"


  

  spec.author       = { "siddhant nigam" => "siddhant.n@vmax.com" }
    spec.platform = :ios, "12.0"



  spec.source       = { :git => "https://github.com/SiddhantVmax/TemplateHelperSiddhant.git", :tag => "0.0.9" }


  

  #spec.source_files  = "TemplateHelperSiddhant"
  spec.source_files  = ["TemplateHelperSiddhant/Sources/**/*.swift", "TemplateHelperSiddhant/Kingfisher.h"]
  spec.exclude_files = "Classes/Exclude"

  

  

end
