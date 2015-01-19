# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'
require 'bubble-wrap/ui'
require 'bubble-wrap/media'
# require 'motion-pixatefreestyle'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'LiftIt'
  app.interface_orientations = [:portrait]
  app.pixatefreestyle.framework = 'vendor/PixateFreestyle.framework'

  app.pods do
    pod 'MZTimerLabel'
  end
end
