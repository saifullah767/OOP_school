require './base_decorator'

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.strip.capitalize
  end
end
