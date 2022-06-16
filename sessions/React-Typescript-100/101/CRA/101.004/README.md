First Components - Header and Footer

Header

Create `components` folder in `src`.
Create `Header` folder in `components`.
Create `Header.tsx`;
    import React from 'react';

    export default function Header() {
        return (
            <div>
            <h1>How is the weather?</h1>
            </div>
        );
    }

Add component to `App.tsx`
    import React from 'react';
    import Header from './components/Header/Header';

    export default function App() {
        return (
            <>
            <Header />
            <h1>React App</h1>
            </>

        );
    }

Create folder and file: `./styles/reset.css`:
    html, body, div, span, applet, object, iframe,
    h1, h2, h3, h4, h5, h6, p, blockquote, pre,
    a, abbr, acronym, address, big, cite, code,
    del, dfn, em, img, ins, kbd, q, s, samp,
    small, strike, strong, sub, sup, tt, var,
    b, u, i, center,
    dl, dt, dd, ol, ul, li,
    fieldset, form, label, legend,
    table, caption, tbody, tfoot, thead, tr, th, td,
    article, aside, canvas, details, embed, 
    figure, figcaption, footer, header, hgroup, 
    menu, nav, output, ruby, section, summary,
    time, mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-size: 100%;
        font: inherit;
        vertical-align: baseline;
    }
    /* HTML5 display-role reset for older browsers */
    article, aside, details, figcaption, figure, 
    footer, header, hgroup, menu, nav, section {
        display: block;
    }
    body {
        line-height: 1;
    }
    ol, ul {
        list-style: none;
    }
    blockquote, q {
        quotes: none;
    }
    blockquote:before, blockquote:after,
    q:before, q:after {
        content: '';
        content: none;
    }
    table {
        border-collapse: collapse;
        border-spacing: 0;
    }
    h1 {
        color: red;
    }

Add to App.tsx
    import '../styles/reset.css';

A reset stylesheet (or CSS reset) is a collection of CSS rules used to clear the browser's default formatting of HTML elements, removing potential inconsistencies between different browsers.

!!Notice the h1 is in red this is because the `styles.module.css` is applied to anything used in the `App.tsx` file.

Show how you can override css with inline css by using the line
    <h1 style={{ color: 'blue' }}>How is the weather?</h1>

Add the following for h1 styles in css file
    h1 {
        font-size: 25px;
        font-weight: 600;
    }
NOTE: we will be adding theming later otherwise you should create a new css file 

Add inline styles in `header.tsx`:
    <div style={{
        color: '#fff',
        backgroundColor: '#005985',
        padding: '24px 12px',
        }}
    >

Adding Icons in the terminal use `yarn add @fortawesome/fontawesome-svg-core @fortawesome/free-solid-svg-icons @fortawesome/react-fontawesome @fortawesome/free-brands-svg-icons`;


Ask them to make a Footer with links to social media (Facebook, Twitter, etc);
And add some text.

import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFacebook, faTwitter } from '@fortawesome/free-brands-svg-icons';

export default function Footer() {
  return (
    <div style={{ backgroundColor: '#3B3B3B', padding: '24px 12px', color: '#fff' }}>
      <div style={{ display: 'flex', justifyContent: 'center' }}>
        <a href="www.facebook.com" target="_blank" aria-label="facebook" style={{ marginRight: '12px' }}>
          <FontAwesomeIcon icon={faFacebook} size="2x" color="#fff" />
        </a>
        <a href="www.twitter.com" target="_blank" aria-label="twitter">
          <FontAwesomeIcon icon={faTwitter} size="2x" color="#fff" />
        </a>
      </div>
      <p style={{ padding: '12px' }}>
        A seven-day forecast can accurately predict the weather about 80 percent of the time
        and a five-day forecast can accurately predict the weather approximately 90 percent
        of the time. However, a 10-day or longer forecast is only right about half the time.
      </p>
    </div>
  );
}

Add to `App.tsx`:
    import React from 'react';
    import Footer from './components/Footer/Footer';
    import Header from './components/Header/Header';
    import './styles.module.css';

    export default function App() {
        return (
            <>
            <Header />
            <h1>React App</h1>
            <Footer />
            </>

        );
    }
