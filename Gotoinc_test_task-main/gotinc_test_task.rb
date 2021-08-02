# Gotoinc_test_task
  module Validation
    def self.included(base)
      base.extend(ValidationClass)
    end
    module ValidationClass
      def names
        @names ||= []
      end
      def validate(attribute_name, options = {})
        names << { name: attribute_name, options: options }
      end
    end
    def validate!
      self.class.names.each do |val|
        if val[:options][:presence]
          presence_validation(val[:name])
        elsif val[:options][:type] && send(val[:name])
          type_validation(val[:name], val[:options][:type])
        elsif val[:options][:greater_than] && send(val[:name])
          greater_than_validation(val[:name], val[:options][:greater_than])
        end
      end
      true
    end
    def valid?
      validate!
    rescue StandardError
      false
    end
    private
    def presence_validation(name)
      return unless send(name).nil? || send(name) == ''
      raise StandardError, "#{name.capitalize} can't be blank"
    end
    def type_validation(name, instance)
      return if send(name).is_a?(User)
      raise StandardError, "#{name.capitalize} should be an instance of #{instance}"
    end
    def greater_than_validation(name, number)
      return if send(name) > number
      raise StandardError, "#{name.capitalize} should be an greater than #{number}"
    end
  end
