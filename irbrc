begin
  require "rubygems"
  require "pry"
rescue LoadError => e
end

if defined? Pry
  extend Rails::ConsoleMethods if defined? Rails::ConsoleMethods
  Pry.start
  exit
else
  # Pry not available
  require "irb/ext/save-history"
  require "irb/completion"
  IRB.conf[:SAVE_HISTORY] = 1000
  IRB.conf[:HISTORY_FILE] = "~/.config/irb_history"
  IRB.conf[:USE_READLINE] = true
end
