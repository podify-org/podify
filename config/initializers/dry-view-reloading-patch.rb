# TODO: only in development

require 'dry/view'
require 'dry/view/renderer'
require 'dry/view/path'
require 'dry/view/scope_builder'
require 'dry/view/part_builder'
require 'dry/view/tilt'

module Dry
  class View
    def self.reset_cache!
      [self, Renderer, Path, ScopeBuilder, PartBuilder, Tilt].each do |klass|
        klass.instance_variable_set(:@__cache__, ::Concurrent::Map.new)
      end
      nil
    end
  end
end
