module HighriseStyle

  module Common
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::JavaScriptHelper

    (ActionView::Helpers::FormBuilder.field_helpers - %w(radio_button hidden_field) + %w(select)).each do |selector|
      define_method "span_options_eoc_#{selector}" do |object, field, options|
        span_options = {}
        value = object.send(field)
        span_options[:show_alt_text] = value.blank?
        span_options[:alt_text] = options[:alt_text] || "Click to edit"
        span_options[:id] = options[:id] || "#{@object.class.to_s.underscore}_#{field}"
        return span_options
      end
    end


    def replace_input(html, options)
      label_match = html.match(/(<label.*?<\/label>)/)
      label_html = label_match.nil? ? "" : label_match[1]
      input_html = html.gsub(/<label.*?<\/label>/, "")
      input_html = input_html.gsub(/<p>/, "")
      input_html = input_html.gsub(/<\/p>/, "")

      if options[:show_alt_text]
        alt_style       = "padding:10px;color:gray;cursor:pointer"
        content_style   = "display:none;"
        alt_id      = "eoc_alt_#{options[:id]}"
        content_id  = "eoc_content_#{options[:id]}" 
        wrap_id     = "eoc_wrap_#{options[:id]}" 


        alt_text = content_tag(:span, "#{options[:alt_text]}", :id => alt_id, :style => alt_style, :class => "eoc-alt")
        input_elem = content_tag(:span, input_html, :style => content_style, :id => content_id, :class => "eoc-content eoc-unchanged")
        content_tag(:span, label_html + alt_text + input_elem, :id => wrap_id, :class => "eoc-closed" ) + javascript_tag("new EditOnClick('#{alt_id}', '#{content_id}', '#{wrap_id}')")

      else
        html
      end
    end
  end
end
