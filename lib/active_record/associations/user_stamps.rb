module ActiveRecord   # :nodoc:
  module Associations # :nodoc:
    module UserStamps  # :nodoc:
      ##
      # Extends ActiveRecord::Base with ClassMethods
      def self.included base
        base.extend(ClassMethods)
      end

      ##
      # Methods added to ActiveRecord::Base
      module ClassMethods
        ##
        # Creates associations for +created_by+ and +updated_by+ using the respective configuration of each.
        def stamped_by user_model
          created_by user_model
          updated_by user_model
        end

        ##
        # Creates an association on the +created_by+ column to the supplied +user_model+ argument.
        # You can override the +created_by+ column name with :foriegn_key but at that point you might
        # as well set up the relationship yourself.
        #
        # Required by default.
        def created_by user_model, options = {}
          user_association :creator, user_model, options.reverse_merge(:foreign_key => 'created_by', :required => true)
        end

        ##
        # Creates an association on the +updated_by+ column to the supplied +user_model+ argument.
        # You can override the +updated_by+ column name with :foriegn_key but at that point you might
        # as well set up the relationship yourself.
        #
        # Not required by default.
        def updated_by user_model, options = {}
          user_association :updator, user_model, options.reverse_merge(:foreign_key => 'updated_by', :required => false)
        end

        private
          def user_association association, user_model, options
            configuration = {:class_name => user_model.to_s.classify}.merge!(options)

            belongs_to association, :foreign_key => configuration[:foreign_key], :class_name => configuration[:class_name]
            validates_presence_of association if configuration[:required]
          end
      end
    end
  end
end