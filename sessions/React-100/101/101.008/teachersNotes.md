# Using React Router



## Notes

  * yarn add react-router-dom
  * import { BrowserRouter as Router } from 'react-router-dom';
  * Wrap app in the router
  * import { Route }
  * Add route <Route path="/" render={() => <h1>Hello World</h1>)} />
  * Change to home
  * Add routes for other two pages
  * Open inspect in browser and show how the whole page reloads
  * import { Link }
  * <Link to="/">Home</Link>
  * Talk about using exact to remove home page on every page
  * Wrap routes in Switch to load only one at a time
  * Remove exact and move home to the bottom to prove switch works
  * Goto /hello to show why we need exact on the homepage
  * Add custom routes
    * data ['Hannah', 'Fred', 'Charlie', 'Tom', 'Sarah', 'Maddie']
    * <Link to={`/about/${name}`}>{name}</Link>
    * <Route path="/about/:name" render={About} />
    * log the props (match.params.name)
    * Add About {name} title
  * Passing props to the component
    * Pass text down to about
    * Add lodash
    * Add passing props to the component
  * Using functions to change the page
    * history is attached to the props with three methods: goBack, goForward & push
    * <button onClick={() => props.history.push('/')}>Go Home</button>
  * Redirect
    * Pass phoneNo to Contact
    * if (!phoneNo) return <Redirect to="/" />
    * Pass down phoneNo
  * Add 404 at the end of the switch route
    * at the bottom of the switch
  * Use History hook
    * import { useHistory } from "react-router-dom";
    * const history = useHistory();
  * useParams && useLocation
  * WithRouter to add these into none pages

