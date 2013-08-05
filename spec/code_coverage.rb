require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start do
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/spec/'
  add_filter '/features/'
end