module ClassBuilder
  class Builder
    def initialize(class_spec_filename)
      specs = File.readlines(class_spec_filename).map do |line|
        type, spec = line.strip.split /:\s*/
        ClassBuilder.const_get(type).new(*spec.split(/,\s*/))
      end
      @start_point = assemble_specs(specs)
    end

    def build
      @start_point.build
    end

    private
    def assemble_specs(specs)
      klass = specs.select{|spec| spec.is_a?(Class)}[0]
      attributes = specs.select{|spec| spec.is_a?(Attributes)}
      constraints = specs.select{|spec| spec.is_a?(Constraint)}

      klass.attributes.push(*attributes)
      attributes.each {|attr| attr.constraints.push(*constraints.select{|c| c.attribute_name == attr.name})}

      klass
    end
  end
end
