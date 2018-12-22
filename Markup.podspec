Pod::Spec.new do |s|
  s.name         = "Markup"
  s.version      = "2.1"
  s.summary      = "Lightweight markup text formatting in Swift"
  s.description  = <<-DESC
    Markup generates attributed strings using a familiar markup syntax:

    * To emphasize words or sentences, you can surround the text with \*asterisks\* to create bold text or \_underscores\_ for italic text.
    * To show corrections in the text, surround the text with \~tildes\~ to strike out the text.
    * You can combine formatting options.
  DESC
  s.homepage     = "https://github.com/gonzalezreal/Markup"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Guille Gonzalez" => "gonzalezreal@icloud.com" }
  s.social_media_url   = "https://twitter.com/gonzalezreal"
  s.screenshot  = 'https://raw.githubusercontent.com/gonzalezreal/Markup/master/MarkupExample/Screenshot.png'
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/gonzalezreal/Markup.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end
