# React example without JSX
Setting up project without create-react-app:

  1. Use terminal: `git init`
 
  2. Create folders: 
     - `src`: used for our application source code
     - `public`: used for our `.html` file
  
  3. Add `build` and `node_modules` folders to `.gitignore` file
  4. Initialise the npm project/package
     - Use terminal: `npm init`

  5. Create file `/public/index.html`

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

  6. Add essential dependencies for ReactJs
     - Use terminal: `yarn add react react-dom` 

  7. To use TypeScript with our React project, we need some additional dev dependencies
     - Use terminal: `yarn add -D typescript @types/react @types/react-dom` 

  8. Create new file: `tsconfig.json` (TODO: Look at the one created in typescript 101 sessions)
     
         {
           "include": [
               "src/*",
               "./declarations.d.ts"
           ],
           "compilerOptions": {
               "target": "es5",
               "jsx": "react",
               "allowSyntheticDefaultImports": true
           }
         }

  9. Create file: `src/App.tsx`

         import React from 'react';
      
         const App = () => (
             <h1>React App</h1>
         );
      
         export default App;

  10. Create new file: `src/index.tsx`

          import React from 'react';
          import ReactDOM from 'react-dom';
          import App from './App';
     
          ReactDOM.render(<App />, document.getElementById('app'));

  11. Babel is a compiler which will convert all code to ES5 allowing the browser to read it, and it will be required even if we were not using TS, in order to convert ES6+ to ES5. 
      - Use terminal: `yarn add -D  @babel/core @babel/preset-env @babel/preset-react @babel/preset-typescript @babel/plugin-transform-runtime`
  12. Create file: `.babelrc` 

          {
              "presets": [
                  "@babel/preset-env",
                  [
                      "@babel/preset-react",
                      { "runtime": "automatic" }
                  ],
                  "@babel/preset-typescript"
              ],
              "plugins": [
                  [
                      "@babel/plugin-transform-runtime",
                      { "regenerator": true }
                  ]
              ]
          }

  13. Webpack is the module bundler which will compile all the javascript files or modules into single file called as bundle.
      - Use terminal: `yarn add -D webpack webpack-cli webpack-dev-server html-webpack-plugin babel-loader`
      - Create new folder: `webpack`
      - Create new file: `webpack/webpack.config.js`

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
                            loader: 'babel-loader',
                            options: {
                                presets: ['@babel/preset-env', '@babel/preset-react']
                            }
                        }
                    ]
                },
                output: {
                    path: path.resolve(__dirname, '..', './build'),
                    filename: 'bundle.js',
                    assetModuleFilename: 'assets/[hash][ext][query]'
                },
                mode: 'development',
                plugins: [
                    new HtmlWebpackPlugin({
                        template: path.resolve(__dirname, '..', './public/index.html')
                    })
                ]
            } 

  14. Add following lines to `scripts` in `package.json`: 
      - ```
        "start": "webpack serve --config webpack/webpack.config.js --open",
        "build": "webpack --config webpack/webpack.config.js"
        ```
      - run the following commands in terminal, and both should work
        1. `npm run build`: will provide the transpiled version of the application in `build` folder
        2. `npm start`: will run the development-server of webpack, which is used for live view of changes made during the application development 
  15. In `index.tsx`, Change `ReactDOM.render` into ` ReactDOM.createRoot` 

          import React from 'react';
          import * as ReactDOM from 'react-dom/client';

          import App from './App';
    
          const root = ReactDOM.createRoot(document.getElementById("app"));
          root.render(
             <React.StrictMode>
                 <App />
             </React.StrictMode>
          );

  16. Additional Section for adding css files
      - Add file: `src/styles.css`

             h1 {
                 color: red;
             }
      - Import css file to `App.tsx`

            import React from 'react';
            import './styles.css';
      
            const App = () => (
               <h1>React App</h1>
            );

            export default App;
      
  17. Use terminal: `yarn add -D css-loader style-loader`
  18. Add to `rules` in `webpack.config.js`

            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            }

  19. Additional Section for adding images
      - Add file: `declarations.d.ts`

             declare module '*.ico';
             declare module '*.gif';
             declare module '*.png';
             declare module '*.jpg';
             declare module '*.jpeg';

      - Add to `rules` in `webpack.config.js` 

            {
                test: /\.(?:ico|gif|png|jpg|jpeg)$/i,
                type: 'asset/resource'
            }

      - Create folder `assets/images`, and copy file `image.jpg` into it.

      - Change the App.tsx

            import React from 'react';
            import './styles.css';
            import image from '../assets/images/image.jpg';
    
            const App = () => (<>
                <h1>React App</h1>
                <img src={image}/>
            </>);
    
            export default App;

  20. For svg's, Add in file `declarations.d.ts`:

          declare module '*.svg'

  21. Add to `rules` in `webpack.config.js` 

          {
              test: /\.(woff(2)?|eot|ttf|otf|svg)$/,
              use: ['asset/inline']
          }
