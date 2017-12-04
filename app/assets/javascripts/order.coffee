class OrdersController
  constructor: ->
    @handle_address()
    display = document.querySelector('.timer');
    if display
      fifteen_minutes = 60 * parseFloat(display.textContent)
      @activate_timer(fifteen_minutes, display)
      $('iframe').on('load', ->
#        window.orderui.resize_iframe(this)
      )

  handle_address: ->
    element = document.querySelector('.order-address')
    $(element).suggestions
      token: '23f6dc56b49d90af5f7ea59dcf7e4f1705d0703a'
      type: 'ADDRESS'
      count: 5
      onSelect: (suggestion) ->
        event = new Event("change", { bubbles: true, cancelable: true })
        element.dispatchEvent(event)
        return

  activate_timer: (duration, display) ->
    timer = duration
    minutes = undefined
    seconds = undefined
    setInterval (->
      minutes = parseInt(timer / 60, 10)
      seconds = parseInt(timer % 60, 10)
      minutes = if minutes < 10 then '0' + minutes else minutes
      seconds = if seconds < 10 then '0' + seconds else seconds
      display.textContent = minutes + ':' + seconds
      if --timer < 0
        timer = duration
      return
    ), 1000
    return

  resize_iframe: (obj) ->
    console.log(obj)
    obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';


$(document).on( 'turbolinks:load', ->
  window.orderui = new OrdersController()
)

addFormValidator "new-order", {
  "ajax:success": (e, response) ->
    validator = arguments.callee.parent
    if response.result is "ok"
      Turbolinks.visit response.redirect
    else
      errorsBox = document.querySelector(".order-errors")
      errorsBox.innerHTML = ""
      for type, list of response.errors
        error = ""
        for j, text of list
          if Number(j) isnt 0
            error += " / "
          error += text
        field = validator.searchByName(type)
        if field?
          field.alert(error)
          field.setState false
        else
          errorsBox.innerHTML = errorsBox.innerHTML + error + "<br />"
}