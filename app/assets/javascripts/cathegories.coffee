class CathegoryPropertiesController
  constructor: ->
    @handle_cathegory_changed()
    inputs_handler()

  handle_cathegory_changed: ->
    $("input[name='item[cathegory_ids][]']").change (e)->
      inputs_handler(e)

  get_properties_data =  (ids) ->
    $.ajax "/cathegories/by_ids/#{ids}",
           type: 'GET',
           dataType: 'JSON',
           success: (data, status) =>
             cats = data.data.categories
             parents = data.data.parents
             cats.forEach (cat,i) ->
               if $("[cat_id='#{cat.id}']").length == 0
                 container = $("<fieldset />").attr('class','p_input_wrapper').attr('cat_id', cat.id)
                 header = $("<p />").attr('class','name').html(cat.name)
               else
                 container = $("[cat_id='#{cat.id}']")
               list = $('<ol />')
               if header
                 container.append(header)
               if cat.properties
                 cat.properties.array.forEach (e,i) ->
                   list.append(generate_input(e, i))
                 container.append(list)
               $('.properties_fieldset').append(container)
               $("#item_cathegory_ids_#{cat.id}").attr('data-parents', parents)
             parents.forEach (parent, i) ->
               $("#item_cathegory_ids_#{parent}").prop('checked', true)
               $("#item_cathegory_ids_#{parent}").prop('readonly', true)


  generate_input = (element,index) =>
    if $("[pr_id='#{element.id}']").length == 0
      type = class_name(element.control_type)
      wrapper = $('<li />').attr('class',"#{type} input optional numeric stringish").attr('pr_id',element.id)
      label = $('<label />').attr('for',"item_property_value_#{element.id}").html("#{element.name} #{element.prefix}")
      hidden = $('<input />').attr('value',element.id).attr('name', "item[property_values_attributes][#{index}][property_id]")
              .attr('type','hidden').html(element.id)
      wrapper.append(hidden)
      switch element.control_type
        when 'string'
          input = $('<input />').attr('class','property_input').attr('placeholder',element.postfix)
                  .attr('type',type).attr('id',"item_property_value_#{element.id}")
                  .attr('name', "item[property_values_attributes][#{index}][string_value]")
        when 'boolean'
          input = $('<input />').attr('class','property_input').attr('placeholder',element.postfix)
                  .attr('type','checkbox').attr('id',"item_property_value_#{element.id}")
                  .attr('name', "item[property_values_attributes][#{index}][string_value]")
        when 'float', 'integer'
          input = $('<input />').attr('class','property_input').attr('placeholder',element.postfix)
                  .attr('type',type).attr('id',"item_property_value_#{element.id}")
                  .attr('name', "item[property_values_attributes][#{index}][float_value]")
        when 'select'
          input = $('<select />').attr('class','property_input').attr('placeholder',element.postfix)
                  .attr('type',type).attr('id',"item_property_value_#{element.id}")
                  .attr('name', "item[property_values_attributes][#{index}][string_value]")
          input.append($('<option />').attr('value','').html(''))
          element.values.forEach (val) ->
            input.append($('<option />').attr('value',val).html(val))
      if input
        label.append(input)
        wrapper.append(label)
      return wrapper

  class_name = (control_type) ->
    return switch control_type
      when 'float', 'integer'
        'number'
      when 'select'
        'select'
      when  'multiselect'
        'check_boxes'
      else
        control_type

  inputs_handler = (e,data) ->
    ids = $("input[name='item[cathegory_ids][]']:checked").toArray().map (elem) ->
      elem.value
    ids = ids.join(',')
    if ids.length > 0
      get_properties_data ids
    inactive = $("input[name='item[cathegory_ids][]']:not(:checked)").toArray().map (elem) ->
      elem.value
    inactive.forEach (id) ->
      $("[cat_id='#{id}']").remove()
    if e && ! $(e.target).prop('checked')
      parents_attr = $(e.target).attr('data-parents')
    if parents_attr
      parents = parents_attr.split(',')
      parents.forEach (id) ->
        $("#item_cathegory_ids_#{id}").prop('readonly', false)

$(document).ready ->
  window.ActiveAdmin.cat_controller = new CathegoryPropertiesController()