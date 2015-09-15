Link = ReactRouter.Link

Templates.Navigation = React.createClass
    render: ->
        <nav className="fixed-top">
            <div className="branding">
                <div className="logo-text">
                    <span>Zero</span>
                    <span className="sub-text">engine!</span>
                </div>
            </div>
            <div className="navigation">
            <Link to="todo">Todo</Link>
                <Link to="about">Go to About</Link>
                <Link to="users">Go to Users</Link>
                <Link to="car">Go to Car</Link>
                <Link to="recent-cars">Go to Cars</Link>
            </div>
            <div id="addon-navs" className="navigation right"></div>
        </nav>