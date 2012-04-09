Gem::Specification.new do |s|
  s.name    = 'rdio-simple-gem'
  s.version = '0.0.1'
  s.summary = 'This is a modified version of the Rdio official rdio-simple ruby library that works in Ruby 1.9.x'

  s.author   = 'Jonathan Eatherly'
  s.email    = 'jonathan.eatherly@gmail.com'
  s.homepage = 'https://github.com/joneath/rdio-simple-gem'

  # These dependencies are only for people who work on this gem
  s.add_development_dependency 'rspec'

  # Include everything in the lib folder
  s.files = Dir['lib/**/*']

  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'
end
