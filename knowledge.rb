def attribute(name, value = nil, &block)
  true if define_method("#{name}?") { instance_variable_get("@#{name}") }
  if name.class == Hash
    name.each { |key, value| attribute(key, value) }
  else
    attr_writer name
    define_method("#{name}") { instance_variable_defined?("@#{name}") ? instance_variable_get("@#{name}") : instance_variable_set("@#{name}", block ? instance_eval(&block) : value) }
  end
end