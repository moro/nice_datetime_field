module NiceDatetimeField
  module Accessor
    extend ActiveSupport::Concern

    module ClassMethods
      def nice_datetime_accessor(*cols)
        cols.each do |col|
          class_eval <<-RUBY.strip_heredoc, __FILE__, __LINE__ + 1
          def #{col}=(val)
            recognizer = NiceDatetimeField::Accessor::Writer.new(val)
            if recognizer.valid?
              self[:#{col}] = recognizer.datetime
            else
              super(val)
            end
          end
          RUBY
        end
      end
    end

    class Writer
      def initialize(hash)
        @hash = hash
      end

      def valid?
        @hash.is_a?(Hash) && %w[date time].all? {|key| @hash[key] }
      end

      def datetime
        date = Date.parse(@hash['date'])
        hour, min = @hash['time'].split(/\s*:\s*/, 2).map(&:to_i)
        Time.zone.local(date.year, date.mon, date.day, hour, min)
      rescue ArgumentError, TypeError
        @hash.values_at('date', 'time').join(' ')
      end
    end
  end
end
