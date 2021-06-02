module Paginations
  class MiddlePaginationsSchema
    include JSON::SchemaBuilder

    def initialize(object)
      @object = object
    end

    def object_child(parent)
      @object.build_paginate(parent)
    end

    def schema
      object do
        array :data do
          max_items 10
          items do |parent|
            object_child(parent)
          end
        end
        object :meta do
          integer :current_page
          integer :total_pages
        end
        object :links do
          string :self
          string :first
          string :last
          string :next
          string :prev
        end
      end
    end
  end
end
