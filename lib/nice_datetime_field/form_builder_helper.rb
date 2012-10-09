module NiceDatetimeField
  module FormBuilderHelper
    def nice_datetime_field(attr_name, options = {})
      options = {date_class: 'span2 datepicker', time_class: 'span1 timepicker'}.merge(options)
      val = object.send(attr_name)

      label attr_name do
        tags = [
          @template.text_field_tag("#{object_name}[#{attr_name}][date]", val.try {|v| I18n.l(v.to_date) }, class: options[:date_class]),
          @template.text_field_tag("#{object_name}[#{attr_name}][time]", val.try {|v| v.strftime('%H:%M') }, class: options[:time_class]),
        ]

        object.errors[attr_name].each do |error|
          tags << @template.content_tag('span', error, class: 'help-inline')
        end

        tags.join("\n").html_safe
      end
    end
  end
end

