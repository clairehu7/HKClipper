Pod::Spec.new do |s|


  s.name         = "HKClipper"
  s.version      = "0.0.5"
  s.summary      = "裁剪照片的工具，裁剪尺寸可以自定义，可选择裁剪时移动图片或裁剪框"

  s.description  = <<-DESC
                    裁剪照片的工具，裁剪尺寸可以自定义，可选择裁剪时移动图片或裁剪框。裁剪成功后回传照片。
                   DESC

  s.homepage     = "https://github.com/clairehu7/HKClipper"
  s.license      = "MIT"
  s.author       = { "clairehu" => "471339423@qq.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/clairehu7/HKClipper.git", :tag => "0.0.5" }
  s.source_files  = "HKClipperDemo/HKClipperDemo/HKClipperVeiw", "HKClipperDemo/HKClipperDemo/General/HKClipperVeiw/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
