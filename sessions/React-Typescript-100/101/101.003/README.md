# React example without JSX
Setting up project without create-react-app (using EsBuild):

  1. Use terminal: `git init`
 
  2. Create folders: 
     - `src`: used for our application source code
     - `public`: used for our `.html` file
  
  3. Add `build`,`temp`, `node_modules` folders to `.gitignore` file
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
               <script src="bundle.js"></script>
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
  
  11. EsBuild is the module bundler which will compile all the javascript files or modules into single file called as bundle.
         - Use terminal: `yarn add esbuild esbuild-plugin-inline-image esbuild-css-modules-plugin`
         - Use terminal: `yarn add -D live-server`
         - Create file `serve.js`

               const cssModulesPlugin = require("esbuild-css-modules-plugin");
               const inlineImage = require("esbuild-plugin-inline-image");
               const {build} = require("esbuild")
               const liveServer = require("live-server")
    
               ;(async () => {
                   // `esbuild` bundler for JavaScript / TypeScript.
                   await build({
                       logLevel: "info",
                       entryPoints: ["./src/index.tsx"],
                       tsconfig: "tsconfig.json",
                       bundle: true,
                       outfile: "temp/bundle.js",
                       target: ['chrome58', 'firefox57', 'safari11', 'edge16'],
                       plugins: [inlineImage(), cssModulesPlugin()],
                       watch: {
                           onRebuild(err) {
                               err ? error('× Failed') : log('✓ Updated');
                           }
                       }
                   })
                   liveServer.start({
                       open: true,
                       port: 3000,
                       root: "temp",
                   })
               })()

      - Create file `build.js`

            const cssModulesPlugin = require("esbuild-css-modules-plugin");
            const inlineImage = require("esbuild-plugin-inline-image");
            const {build} = require("esbuild")

            build({
                logLevel: "info",
                entryPoints: ["./src/index.tsx"],
                tsconfig: "tsconfig.json",
                bundle: true,
                outfile: "build/bundle.js",
                target: ['chrome58', 'firefox57', 'safari11', 'edge16'],
                plugins: [inlineImage(), cssModulesPlugin()]
            })           

  12. Add following lines to `scripts` in `package.json`: 
      - ```
        "start": "mkdir temp; cp public/index.html temp; node serve.js",
        "build": "node build.js; cp public/index.html build"
        ```
      - run the following commands in terminal, and both should work
        1. `npm run build`: will provide the transpiled version of the application in `build` folder
        2. `npm start`: will run the development-server of webpack, which is used for live view of changes made during the application development 
  13. In `index.tsx`, Change `ReactDOM.render` into ` ReactDOM.createRoot` 

          import React from 'react';
          import * as ReactDOM from 'react-dom/client';

          import App from './App';
    
          const root = ReactDOM.createRoot(document.getElementById("app"));
          root.render(
             <React.StrictMode>
                 <App />
             </React.StrictMode>
          );

  14. Additional Section for adding css files
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

  17. Additional Section for adding images
      - Add file: `declarations.d.ts`

             declare module '*.ico';
             declare module '*.gif';
             declare module '*.png';
             declare module '*.jpg';
             declare module '*.jpeg';

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

  18. For svg's, Add in file `declarations.d.ts`:

          declare module '*.svg'
