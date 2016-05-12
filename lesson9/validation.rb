module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *args)
      @validations ||= []
      @validations << { name: name, type: type, args: args }
    end

    attr_reader :validations
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |val|
        send "validate_#{val[:type]}", val[:name], val[:args]
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def validate_presence(name, *_args)
      raise "@#{name} cannot be empty" if instance_variable_get("@#{name}").to_s.empty?
    end

    def validate_format(name, args)
      regex = args[0]
      raise "@#{name} have wrong format" if instance_variable_get("@#{name}") !~ regex
    end

    def validate_type(name, args)
      type = args[0]
      raise "@#{name} have wrong class" unless instance_variable_get("@#{name}").class.ancestors.include? type
    end
  end
end
