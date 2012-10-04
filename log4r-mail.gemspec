# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log4r/mail_outputter'

Gem::Specification.new do |gem|
  gem.name          = "log4r-mail"
  gem.version       = Log4r::MailOutputter::VERSION
  gem.authors       = ["aoyagikouhei"]
  gem.email         = ["aoyagi.kouhei@gmail.com"]
  gem.description   = %q{Log4R Outputter for mail}
  gem.summary       = %q{Log4R Outputter for mail}
  gem.homepage      = "https://github.com/aoyagikouhei/log4r-mail"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency(%q<log4r>)
  gem.add_dependency(%q<mail>)
end
