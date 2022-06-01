Brief session to add ESlint to project.

Show how the eslint init command works
- options 3
- import/export
- react
- yes typescript
- browser
- answer questions
- JSON

In the terminal: `yarn add -D eslint-config-airbnb-typescript @typescript-eslint/eslint-plugin@^5.13.0 @typescript-eslint/parser@^5.0.0`

Add `"project": "tsconfig.json",` to the `parserOptions` in `.eslintrc.json`

Finally add scripts to `package.json`:
    "lint-ts": "eslint './src/**/*.{ts,tsx}'",
    "lint:fix": "yarn run lint-ts --fix"

Created files

or add these to the dev dependencies in `package.json`:
"eslint": "^8.2.0",
"eslint-config-airbnb": "19.0.4",
"eslint-config-airbnb-typescript": "^17.0.0",
"eslint-plugin-import": "^2.25.3",
"eslint-plugin-jsx-a11y": "^6.5.1",
"eslint-plugin-react": "^7.28.0",
"eslint-plugin-react-hooks": "^4.3.0",

Create file: `.eslintrc.json` 
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

