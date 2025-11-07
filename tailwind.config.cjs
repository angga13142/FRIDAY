/**** Tailwind Config ****/
module.exports = {
  darkMode: 'class',
  content: [
    './src/**/*.{astro,html,js,jsx,tsx,mdx}',
    './public/**/*.html'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'Manrope', 'sans-serif']
      },
      colors: {
        accent: {
          DEFAULT: '#3A7DFF'
        }
      },
      boxShadow: {
        card: '0 4px 14px rgba(0,0,0,0.08)'
      }
    }
  },
  plugins: []
};
