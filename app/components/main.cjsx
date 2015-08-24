Car = React.createClass
  getInitialState: ->
    timeRemaining: 10

  tick: ->
    actualTimeRemaining = @state.timeRemaining - 1
    if actualTimeRemaining is 0
      @setState { timeRemaining: 'Boom!' }
      clearInterval(@interval)
    else
      @setState { timeRemaining: actualTimeRemaining}

  resetCoolDown: ->
    clearInterval(@interval)
    @setState { timeRemaining: 10 }
    @interval = setInterval @tick, 1000

  componentDidMount: ->
    @interval = setInterval @tick, 1000

  render: ->
    <li onClick={@resetCoolDown}>This is the car {@props.name} {@state.timeRemaining}</li>

CarList = React.createClass
  render: ->
    cars = @props.items.map (item) ->
      <Car name={item.name} />

    return (
      <ul>{cars}</ul>
    );

cars = [
  name: "Car 1"
,
  name: "Car 2"
,
  name: "Car 3"
]

React.render(<CarList items={cars}/>, document.body)