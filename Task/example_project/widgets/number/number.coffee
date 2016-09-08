class Dashing.Number extends Dashing.Widget
  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Fired when you receive data
    # You could do something like have the widget flash each time data comes in by doing:
    # $(@node).fadeOut().fadeIn()

  # Any attribute that has the 'Dashing.AnimatedValue' will cause the number to animate when it changes. 
  @accessor 'current', Dashing.AnimatedValue

  # Calculates the % difference between current & last values.
  @accessor 'difference', ->
    if @get('last')
      last = parseInt(@get('last'))
      current = parseInt(@get('current'))
      if last != 0
        diff = Math.abs(Math.round((current - last) / last * 100))
        "#{diff}%"
    else
      ""
  # Picks the direction of the arrow based on whether the current value is higher or lower than the last
  @accessor 'arrow', ->
    if @get('last')
      if parseInt(@get('current')) > parseInt(@get('last')) then 'icon-arrow-up' else 'icon-arrow-down'