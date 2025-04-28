class FormController < ApplicationController
  def blank_form

  render({ :template => "form_templates/form_trial" })
  end
end
