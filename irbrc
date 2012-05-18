begin
  load '/etc/irbrc' # OS X defaults.
  local_irbrc = "ENV['HOME']/.irbrc_local"
  load local_irbrc if File.exists?(local_irbrc)
  require 'rubygems'
  require 'method_lister'
rescue LoadError
end

require 'pp'

# print SQL to STDOUT
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

# Autocomplete
require 'irb/completion'

# Prompt behavior
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]

# History
require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Use awesome_print instead of #inspect, when available
IRB::Irb.class_eval do
  def output_value
    begin; require 'ap'; rescue LoadError; end
    if @context.last_value.respond_to?(:awesome_inspect)
      printf @context.return_format, @context.last_value.awesome_inspect
    else
      printf @context.return_format, @context.last_value.inspect
    end
  end
end
