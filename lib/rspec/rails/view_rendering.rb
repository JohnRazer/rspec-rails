module Rspec
  module Rails
    module ViewRendering
      extend ActiveSupport::Concern

      module ClassMethods
        def metadata_for_rspec_rails
          metadata[:rspec_rails] ||= {}
        end

        def render_views
          metadata_for_rspec_rails[:render_views] = true
        end

        def render_views?
          metadata_for_rspec_rails[:render_views]
        end
      end

      included do
        before do
          @_view_paths = controller.class.view_paths
          controller.class.view_paths = [Rspec::Rails::NullResolver.new()] unless
            self.class.render_views?
        end

        after do
          controller.class.view_paths = @_view_paths
        end
      end
    end
  end
end
