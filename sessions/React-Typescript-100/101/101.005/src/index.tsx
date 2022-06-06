import React from 'react';
import * as ReactDOM from 'react-dom/client';

import App from './App';

const modalRoot = document.getElementById('#app') as HTMLElement;
const root = ReactDOM.createRoot(modalRoot);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
);
