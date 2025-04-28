class FormController < ApplicationController
  def blank_form

    render({ :template => "form_templates/form_trial" })
  end
  def proc_inputs
    @the_image=params.fetch("image_param", "not there")
    # @the_image=params.fetch["image_param"] #esto te devuelve nil
    @description=params.fetch("description_param")
    render({ :template => "form_templates/p_results" })
  end
end
