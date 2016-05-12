module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(attr_name, validation_type, *args)
      case validation_type
      when :presence
        define_method("#{attr_name}_#{validation_type}".to_sym) do
          eval("raise '@#{attr_name} cannot be nil or empty' if @#{attr_name}.to_s.empty?")
        end
      when :format
        define_method("#{attr_name}_#{validation_type}".to_sym) do
          eval("raise '@#{attr_name} have wrong format' if @#{attr_name} !~ args[0]")
        end
      when :type
        define_method("#{attr_name}_#{validation_type}".to_sym) do
          eval("raise '@#{attr_name} have wrong class' if @#{attr_name}.class != args[0]")
        end
      end

      @validations ||= []
      @validations << "#{attr_name}_#{validation_type}".to_sym

      # class << self
      #   attr_accessor :validations
      # end
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.validations
      validations ||= []
      validations.each do |method|
        eval("#{method}")
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end
  end
end

# class X
#   include Validation
#   attr_accessor :a, :b, :c, :d
#   validate :a, :presence
#   validate :b, :format, /\d/
#   validate :a, :type, Fixnum
# end