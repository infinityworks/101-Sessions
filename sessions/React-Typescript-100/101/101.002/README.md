# React example without JSX
Setting up project without create-react-app
  Use terminal: `git init`
  TODO: decide on whether to have a public fodler and why
  Create two folders: `build` & `src` & `public`
  Add build file to git ignore
  Use terminal: `npm init`

  Create file `/public/index.html`
    <!DOCTYPE html>
    <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <meta http-equiv="X-UA-Compatible" content="ie=edge">
          <title>Document</title>
      </head>
      <body>
          <div id="app"></div>
      </body>
    </html>

  Use terminal: `yarn add react react-dom` 

  This is all you need for React for JS but to use TS we need some addtional dev dependancies
  Use terminal: `yarn add -D typescript @types/react @types/react-dom` 

  Create new file: `tsconfig.json` (TODO: Look at the one created in typescript 101 sessions)
    {
      "include": [
          "src/*"
      ],
      "compilerOptions": {
          "target": "es5",
          "jsx": "react",
          "allowSyntheticDefaultImports": true
      }
    }

  Create file: `src/App.tsx`
    const App = () => (
      <h1>React App</h1>
    )

  Create new file: `src/index.tsx`
    import ReactDom from 'react-dom';
    import App from './App';

    ReactDOM.render(<App />, document.getElementById('app'));

  Using Babel is a compiler which will convert all code to ES5 allowing the browser to read it. 
  (This would still be required even if we were not using TS, in order to convert ES6 to ES5) 
  Use terminal: `yarn add -D  @babel/core @babel/preset-env @babel/preset-react @babel/preset-typescript @babel/plugin-transform-runtime`
  Create file: `.babelrc` 
    {
      "presets": [
        "@babel/preset-env",
        [
          "@babel/preset-react",
          {
            "runtime": "automatic"
          }
        ],
        "@babel/preset-typescript"
      ],
      "plugins": [
        [
          "@babel/plugin-transform-runtime",
          {
            "regenerator": true
          }
        ]
      ]
    }

  Webpack is the module bundler which will compile all the javascript files or modules into single file called as bundle.
  Use terminal: `yarn add -D webpack webpack-cli webpack-dev-server html-webpack-plugin babel-loader`
  Create new folder: `webpack`
  Create new file: `webpack/webpack.config.js`
    const path = require('path')
    const HtmlWebpackPlugin = require('html-webpack-plugin')

    module.exports = {
        entry: path.resolve(__dirname, '..', './src/index.tsx'),
        resolve: {
            extensions: ['.tsx', '.ts', '.js']
        },
        module: {
            rules: [
                {
                    test: /\.(ts|js)x?$/,
                    exclude: /node_modules/,
                    use: [
                        {
                            loader: 'babel-loader'
                        }
                    ]
                }
            ]
        },
        output: {
            path: path.resolve(__dirname, '..', './build'),
            filename: 'bundle.js',
        },
        mode: 'development',
        plugins: [
            new HtmlWebpackPlugin({
                template: path.resolve(__dirname, '..', './public/index.html')
            })
        ]
      } 

Add line to `scripts` in `package.json`: `"start": "webpack serve --config webpack/webpack.config.js --open"`


Convert from `ReactDOM.render` to ` ReactDOM.createRoot` in index.tsx
  import { createRoot } from "react-dom/client";

  const root = ReactDOM.createRoot(document.getElementById("root"));
  root.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>
  );

Additonal Section for adding css files
Add file: `public/styles.css`
  h1 {
    color: 'red';
  }

Import css file to `App.tsx`
Use terminal: `yarn add -D css-loader style-loader`
Add to `rules` in `webpack.config.js`
  {
    test: /\.css$/,
    use: ['style-loader', 'css-loader']
  }

Additonal Section for adding images
Add file: `declarations.d.ts`
  declare module '*.png'

Add to `rules` in `webpack.config.js` 
  {
    test: /\.(?:ico|gif|png|jpg|jpeg)$/i,
    use: ['asset/resource']
  }

For svg's
Add in file `declarations.d.ts`:
  declare module '*.svg'

Add to `rules` in `webpack.config.js` 
  {
    test: /\.(woff(2)?|eot|ttf|otf|svg)$/,
    use: ['asset/inline']
  }
