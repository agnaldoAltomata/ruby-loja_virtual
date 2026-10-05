require File.expand_path("../lib/active_file/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "active_file"
  gem.version     = ActiveFile::VERSION
  gem.author      = "Agnaldo de Assis"
  gem.files       = Dir["{lib/**/*.rb,lib/tasks/*.rake,README.md,Rakefile,active_file.gemspec}"]
  gem.summary     = "Just a file system database"
  gem.description = "ActiveFile is a lightweight gem that provides a simple database interface using the local file system."
  gem.license     = "MIT"
  gem.homepage    = "https://github.com" 
  gem.required_ruby_version = ">= 3.0" 
end