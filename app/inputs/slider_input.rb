class SliderInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    merged_input_options[:class].push('bootstrap-slider')
    merged_input_options[:"data-slider-min"] = 0
    merged_input_options[:"data-slider-max"] = 1000
    merged_input_options[:"data-slider-step"] = 5
    merged_input_options[:"data-slider-value"] = @builder.object.send(attribute_name.to_sym) || 500

    puts "@builder #{@builder.inspect}"

    @builder.text_field(attribute_name, merged_input_options)
  end
end
