# Themes

Themes are written in SASS (sassy) with the base theme being `base.scss`.

_Note: Don't edit the `.css` files directly_

## Updating the Base Theme

Make any updates to `base.scss` and then recomplile **both** the base theme and the child-theme e.g: `generation.scss` to produce two stylesheets `generation.css` and `base.css`.

## Updating a Child Theme

Make any updates and recompile the child-theme e.g: `generation.scss` to produce the stylesheet `generation.css`.

## Using a Theme

Configure the MD header prop: `customTheme` to point to your stylesheet, eg:

```sh
customTheme: "static/base"
transition: "slide"
highlightTheme: "monokai-sublime"
```

## Creating a New Child Theme

- create a new `.scss` file
- add the following line: `@import "base";`
- add custom / override styles
- compile to css
- reference in MD file

## Ok... but what is SASS and how does one compile

SASS is a CSS pre-processor that allows you to write smarter CSS.

Easiest way to compile is to install the `vscode` extension `Live Sass` which will watch for changing `SASS` file and compile these for you.

There is a script called `compile-sass.sh` that will compile all of the sass files.

Otherwise you can install `node-sass` and use the terminal to compile manually.
