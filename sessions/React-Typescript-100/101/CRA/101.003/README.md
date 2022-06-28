Using Create react app with typescript

In the terminal: `npx create-react-app weather-app --template typescript`;
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

What is the https://bit.ly/CRA-vitals;
As we had to add into webpack the ability to load css and image files, this file serves the same purpose. 

Finally what about setupTests.ts
The @testing-library/jest-dom library provides a set of custom jest matchers that you can use to extend jest. These will make your tests more declarative, clear to read and to maintain;

Adding Eslint
Create file `.eslintrc.json`
    {
        "env": {
            "browser": true,
            "es2021": true
        },
        "extends": [
            "airbnb",
            "airbnb-typescript"
        ],
        "parser": "@typescript-eslint/parser",
        "parserOptions": {
            "project": "tsconfig.json",
            "ecmaFeatures": {
                "jsx": true
            },
            "ecmaVersion": 12,
            "sourceType": "module"
        },
        "plugins": [
            "react",
            "@typescript-eslint"
        ]
    }

Add to `package.json`:

    `devDependencies`:
        "@typescript-eslint/eslint-plugin": "^5.13.0",
        "@typescript-eslint/parser": "^5.0.0",
        "eslint": "^8.2.0",
        "eslint-config-airbnb": "19.0.4",
        "eslint-config-airbnb-typescript": "^17.0.0",
        "eslint-plugin-import": "^2.25.3",
        "eslint-plugin-jsx-a11y": "^6.5.1",
        "eslint-plugin-react": "^7.28.0",
        "eslint-plugin-react-hooks": "^4.3.0",

    `scripts`:
        "lint-ts": "eslint './src/**/*.{ts,tsx}'",
        "lint:fix": "yarn run lint-ts --fix"

In the terminal: `yarn`

Lets fix those 4 issues in index.tsx and App.tsx

Install eslint extension for vs code 
If the errors don't show in the file. Open VS shell (Shift + cmd + p) and type Eslint: Restart Eslint Server;
