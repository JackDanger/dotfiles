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
end
