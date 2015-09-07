Navigation = React.createClass
    render: ->
        <div className="nav">
            <Link to="todo">Todo</Link>
            <Link to="about">Go to About</Link>
            <Link to="users">Go to Users</Link>
            <Link to="car">Go to Car</Link>
            <Link to="recent-cars">Go to Cars</Link>
        </div>