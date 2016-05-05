module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ? @instances : 0
    end

    private

    def add_instance
      @instances = @instances ? @instances + 1 : 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.send :add_instance
    end
  end
end
