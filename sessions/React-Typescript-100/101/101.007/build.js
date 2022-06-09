const cssModulesPlugin = require("esbuild-css-modules-plugin");
const inlineImage = require("esbuild-plugin-inline-image");
const {build} = require("esbuild")

build({
    logLevel: "info",
    entryPoints: ["./src/index.tsx"],
    tsconfig: "tsconfig.json",
    bundle: true,
    outfile: "build/bundle.js",
    target: ['chrome58', 'firefox57', 'safari11'],
    plugins: [inlineImage(), cssModulesPlugin()]
});