module HighriseStyle

  module FormBuilder
    module EditOnClick
      (ActionView::Helpers::FormBuilder.field_helpers - %w(radio_button hidden_field)).each do |selector|

        include HighriseStyle::Common

        define_method "eoc_#{selector}" do |field, options|
          options ||= {}
          span_options = send("span_options_eoc_#{selector}", @object, field, options)
          replace_input(send("#{selector}", field, options), span_options)
        end

        define_method  "eoc_select" do |field, choices, options, html_options|
          options ||= {}
          html_options ||= {}
          span_options = send("span_options_eoc_#{selector}", @object, field, options)
          replace_input(send("select", field, choices, options, html_options), span_options)
        end
      end
    end
  end

  module Helpers
    module EditOnClick
      include HighriseStyle::Common

      (ActionView::Helpers::FormBuilder.field_helpers - %w(radio_button hidden_field)).each do |selector|
        define_method "eoc_#{selector}" do |object, field, options|
          options ||= {}
          span_options = send("span_options_eoc_#{selector}", object, field, options)
          replace_input(send("#{selector}", object, field, options), span_options)
        end

        define_method "eoc_select" do |object, field, choices, options, html_options|
          options ||= {}
          html_options ||= {}
          span_options = send("span_options_eoc_#{selector}", object, field, options)
          replace_input(send("select", object, field, choices, options, html_options), span_options)
        end
      end
    end
  end

end
