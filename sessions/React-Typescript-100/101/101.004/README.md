Brief session to add ESlint to project.

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

IMPORTANT: Add to `eslintrc.json` in `parserOptions` - "project": "tsconfig.json",
This is to allow use of eslint in typescript files.

To fix `index.tsx`
const modalRoot = document.getElementById('#app') as HTMLElement;
const root = ReactDOM.createRoot(modalRoot);