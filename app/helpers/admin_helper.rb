module AdminHelper
  def class_by_control_type(control_type)
    case control_type
      when 'float', 'integer'
        'number'
      when 'select'
        'select'
      when  'multiselect'
        'check_boxes'
      else
        control_type
      end
  end
end