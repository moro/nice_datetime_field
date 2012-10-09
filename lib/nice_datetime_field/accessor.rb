module NiceDatetimeField
  module Accessor
    extend ActiveSupport::Concern

    module ClassMethods
      def nice_datetime_accessor(*cols)
        cols.each do |col|
          class_eval <<-RUBY.strip_heredoc
          def #{col}=(val)
            recognizer = NiceDatetimeField::Accessor::Writer.new(val)
            recognizer.valid? ? super(recognizer.datetime) : super(val)
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
      rescue ArgumentError
        @hash.values_at('date', 'time').join(' ')
      end
    end
  end
end
