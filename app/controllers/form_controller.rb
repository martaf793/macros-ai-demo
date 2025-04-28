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
      c.user("here is an image", image:@the_image)
      c.user(@description)
      c.schema='{
      "name": "nutrition_info",
      "schema": {
        "type": "object",
        "properties": {
          "carbohydrates": {
            "type": "number",
            "description": "Amount of carbohydrates in grams."
          },
          "protein": {
            "type": "number",
            "description": "Amount of protein in grams."
          },
          "fat": {
            "type": "number",
            "description": "Amount of fat in grams."
          },
          "total_calories": {
            "type": "number",
            "description": "Total calories in kcal."
          },
          "notes": {
            "type": "string",
            "description": "A breakdown of how you arrived at the values, and additional notes."
          }
        },
        "required": [
          "carbohydrates",
          "protein",
          "fat",
          "total_calories",
          "notes"
        ],
        "additionalProperties": false
      },
      "strict": true
    }'
      @structured_output=c.assistant!
      @g_carbs=@structured_output.fetch("carbohydrates")
      @g_fat=@structured_output.fetch("fat")
      @kcal=@structured_output.fetch("total_calories")

      c.assistant!
    render({ :template => "form_templates/p_results" })
  end
end
