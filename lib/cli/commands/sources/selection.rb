require 'dry/cli'

module CLI
  module Commands
    module Sources
      module Selection
        extend ActiveSupport::Concern

        included do
          option :all, type: :boolean, default: false, desc: 'All sources'
          option :id, type: :integer, default: nil, desc: ''
        end

        def selected_sources(args)
          if !args[:all] && args[:id].nil?
            puts 'Don\'t know which sources to select.'
            return []
          end

          sources = Source.dataset
          sources = sources.where(id: args[:id]) if args[:id]

          sources.to_a.tap do |sources|
            if sources.none?
              puts 'No sources found'
            end
          end
        end
      end
    end
  end
end
