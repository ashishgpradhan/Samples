import js from "@eslint/js";
import prettier from "eslint-plugin-prettier";
import globals from "globals";

export default [
  js.configs.recommended, // ESLint recommended rules
  {
    plugins: { prettier },
    rules: {
      "prettier/prettier": "warn", // Prettier integration
    },
    languageOptions: {
      globals: {
        ...globals.node, // ✅ includes process, require, module, etc.
      },
    },
  },
];
