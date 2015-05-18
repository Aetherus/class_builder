module ClassBuilder
  class Constraint
    attr_reader :attribute_name, :statement

    def initialize(attribute_name, statement)
      @attribute_name = attribute_name
      @statement = statement.gsub(attribute_name, 'value')
    end

    def build
      %Q<raise "Invalid value for attribute #{@attribute_name}: \#{value.inspect}" unless #{@statement}>
    end
  end
end
