module Serializable
  def serializer_blueprint(klass_name, resource, meta: {})
    serializer = "#{klass_name.to_s.camelize}Blueprint".constantize

    return serializer.render(resource, root: :data, meta: meta) unless meta.empty?

    serializer.render(resource, root: :data)
  end
end
