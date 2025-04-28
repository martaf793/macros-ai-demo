class FormController < ApplicationController
  def blank_form

    render({ :template => "form_templates/form_trial" })
  end
  def proc_inputs
    @the_image=params.fetch("image_param", "not there")
    # @the_image=params.fetch["image_param"] #esto te devuelve nil
    @description=params.fetch("description_param")

    c=OpenAI::Chat.new 
      c.system("your are an expert nutritionist. The user will give you an image and/or description of a meal")
      @description
      
      c.user(@description)
      c.schema='{
      "name"=" nutrition_facts"
      }'
      @structured_output=c.assistant!
      c.assistant!
    render({ :template => "form_templates/p_results" })

  end
end
