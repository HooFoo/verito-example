Rails.configuration.to_prepare do
  module ActiveRecord
    module Associations
      HasManyAssociation.class_eval do
        def count_records
          count = if reflection.has_cached_counter?
                    owner._read_attribute(reflection.counter_cache_column).to_i
                  else
                    scope.count
                  end

          # If there's nothing in the database and @target has no new records
          # we are certain the current target is an empty array. This is a
          # documented side-effect of the method that may avoid an extra SELECT.
          (@target ||= []) && loaded! if count == 0

          [association_scope.limit_value, count].compact.min
        end
      end
    end
  end
end