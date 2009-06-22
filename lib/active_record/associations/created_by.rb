module ActiveRecord   # :nodoc:
  module Associations # :nodoc:
    module CreatedBy  # :nodoc:
      ##
      # Extends ActiveRecord::Base with ClassMethods
      def self.included base
        base.extend(ClassMethods)
      end

      ##
      # Methods added to ActiveRecord::Base
      module ClassMethods
        ##
        # Creates an association on the +created_by+ column to the supplied +user_model+ argument.
        # You can override the +created_by+ column name with :foriegn_key but at that point you might
        # as well set up the relationship yourself.
        def created_by user_model, options = {}
          configuration = { :foreign_key => 'created_by', :class_name => user_model.to_s.classify }
          configuration.merge!(options) if options.is_a?(Hash)

          belongs_to :creator, :foreign_key => configuration[:foreign_key], :class_name => configuration[:class_name]
        end
      end
    end
  end
end