const cssModulesPlugin = require("esbuild-css-modules-plugin");
const inlineImage = require("esbuild-plugin-inline-image");
const {build} = require("esbuild")
const liveServer = require("live-server")

build({
    logLevel: "info",
    entryPoints: ["./src/index.tsx"],
    tsconfig: "tsconfig.json",
    bundle: true,
    outfile: "temp/bundle.js",
    target: ['chrome58', 'firefox57', 'safari11', 'edge16'],
    plugins: [inlineImage(), cssModulesPlugin()],
    watch: {
        onRebuild(err) {
            err ? console.error('× Failed') : console.log('✓ Updated');
        }
    }
}).then(() => {
    liveServer.start({
        open: true,
        port: 3000,
        root: "temp",
    })
});