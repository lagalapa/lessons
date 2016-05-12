module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name).last if instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        new_value = (instance_variable_get(var_name) || []) << value
        instance_variable_set(var_name, new_value)
      end
      define_method("#{name}_history".to_sym) { instance_variable_get(var_name) }
    end
  end

  def strong_attr_accessor(name, attr_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Wrong argument class' if value.class != attr_class
      instance_variable_set(var_name, value)
    end
  end
end

# class X
#   extend Accessors

#   attr_accessor_with_history :myvar, :a, :bb
#   strong_attr_accessor :lol, Float
# end

