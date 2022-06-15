Using Create react app with typescript

In the terminal: `yarn create react-app weather-app --template typescript`;
Cd into the new folder: `cd weather-app`;

Look at the index.html in the public folder and explain
    - favicon
    - manifest file
    - <div id="root"></div>

In the terminal: `yarn start`;

Lets clean up the src folder:
    Delete the following: App.css, App.test.tsx, index.css, logo.svg

In App.tsx replace with:
    import React from 'react';

    export default function App() {
        return (
            <h1>Weather App</h1>
        );
    }

In index.tsx remove import './index.css';