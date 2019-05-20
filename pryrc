Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'w', 'whereami'
Pry.commands.alias_command 'q', 'disable-pry'

module Kernel
  def ival(name, value = nil)
    if value
      instance_variable_set "@#{name}", value
    else
      instance_variable_get "@#{name}"
    end
  end

  def instance_variables_hash
    instance_variables.reduce({}) { |acc, name| acc.update name => instance_variable_get(name) }
  end
end


begin
  require 'pbcopy'
rescue LoadError
  begin
    require '/Users/jackdanger/.gem/ruby/2.5.1/gems/pbcopy-1.0.1/lib/pbcopy.rb'
    require '/Users/jackdanger/.gem/ruby/2.5.1/gems/pasteboard-1.0/lib/pasteboard.rb'
  rescue LoadError
  end
end
