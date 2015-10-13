module Kernel
  def ivar(name, value = nil)
    if value
      instance_variable_set "@#{name}", value
    else
      instance_variable_get "@#{name}"
    end
  end
end
