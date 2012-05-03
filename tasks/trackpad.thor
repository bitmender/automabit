#!/usr/bin/env ruby

require "thor"

class Trackpad < Thor

  namespace :trackpad
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "disable", "disable the trackpad"
  def disable
    system "xinput set-prop 12 132 0"
    end

  desc "enable", "enable the trackpad"
  def enable
    system "xinput set-prop 12 132 1"
  end


  desc "toggle", "disable if enabled, else disable"
  def toggle 
    device = `xinput list `
    device =~ /PS\/2 Generic Mouse.*=(?<id>\d{1,2})/
    device = $1 
    properties = `xinput list-props #{ device }`
    properties =~ /Device Enabled.*\((\d{3})\):.*(\d)/
    property = $1
    enabled =  $2
    puts "device : #{ device } , property : #{ property } , enabled : #{ enabled }"
    if enabled == "1"
      `xinput set-prop #{device} #{property} 0` 
    else
      `xinput set-prop #{device} #{property} 1`
    end
  end
end

Trackpad.start
