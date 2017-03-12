# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('form.edit_transcript').keypress((e)->
    # Extract the data from the form
    action = $(this).attr('action')
    method = $(this).attr('method')
    data = $(this).serializeArray()

    $.ajax({
      method: 'put',
      url: action,
      data: data,
      dataType: 'script'
    })
  )

  $('button#btn-undo').click((e)->
    e.preventDefault()
    action = $('#btn-undo').data('url')

    $.ajax({
      method: 'put',
      url: action,
      dataType: 'script'
    })
  )

  $('button#btn-redo').click((e)->
    e.preventDefault()
    action = $('#btn-redo').data('url')

    $.ajax({
      method: 'put',
      url: action,
      dataType: 'script'
    })
  )