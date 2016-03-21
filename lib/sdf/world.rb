module SDF
    class World < Element
        xml_tag_name 'world'

        # Enumerates the models from this world
        #
        # @yieldparam [Model] model
        def each_model
            return enum_for(__method__) if !block_given?
            xml.elements.each('model') do |element|
                begin
                    yield(Model.new(element, self))
                rescue Exception => e
                    model_name = element.attributes['name']
                    SDF.error "Error loading model '#{model_name}'"
                    raise e
                end
            end
        end
    end
end

