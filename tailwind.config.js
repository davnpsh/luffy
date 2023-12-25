/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./app/**/*.{html,js,ts,jsx,tsx,coffee}"
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require("@catppuccin/tailwindcss")({
      prefix: "ctp",
      defaultFlavour: "mocha",
    })
  ]
}

