# Using Styled Components

## What are styled components

## Notes

* `npm i styled-components`
* In index.js
  * import styled components
  * Add wrapper to APP
* Button
  * import styled components
  * Add CustomButton styled input
  * Add hover state (`&:hover {}`)
* Add createGlobalStyle
  * create a new file CssReset.js
  * `import { createGlobalStyle } from styled-compoents`
  * use <https://meyerweb.com/eric/tools/css/reset/> for css reset
  * import into `index.js`
* Add Title.js
  * add css for size and weight
  * import into Header
  * use `styled(Header)` to add margin bottom
* Theme
  * `import { ThemeProvider }`
  * `<ThemeProvider theme={{ fontColor: 'red' }}></ThemeProvider>`
  * Use fontColor using `${props => props.theme.fontColor}`
* introduce lodash
  * `npm i lodash`
  * `import { get } from lodash`
  * `get(props, 'theme.fontColor') or get(props, 'theme.fontColor', 'black')`
