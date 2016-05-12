module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      define_method(name) { eval("@#{name} ? @#{name}.last : nil") }
      define_method("#{name}=".to_sym) do |value|
        eval("@#{name} ? @#{name} << value : @#{name} = [value]")
      end
      define_method("#{name}_history".to_sym) { eval("@#{name}") }
    end
  end

  def strong_attr_accessor(name, attr_class)
    define_method(name) { instance_variable_get("@#{name}".to_sym) }
    define_method("#{name}=".to_sym) do |value|
      if value.class == attr_class
        instance_variable_set("@#{name}".to_sym, value)
      else
        raise 'Wrong argument class'
      end
    end
  end
end

# class X
#   extend Accessors
#   extend Validation

#   attr_accessor_with_history :myvar, :a, :bb
#   strong_attr_accessor :lol, Float
# end

