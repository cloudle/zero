Templates.Car = React.createClass
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

Templates.CarList = React.createClass
  render: ->
    return (
      <h1>cars</h1>
    );

cars = [
  name: "Car 1"
,
  name: "Car 2"
,
  name: "Car 3"
]