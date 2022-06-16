import { MantineThemeOverride } from '@mantine/core';

const theme: MantineThemeOverride = {
  fontFamily: 'Open Sans',
  breakpoints: {
    xs: 0,
    sm: 480,
    md: 640,
    lg: 960,
    xl: 1200,
  },
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
  },
  headings: {
    fontWeight: 600,
    sizes: {
      h1: {
        fontSize: '30px',
      },
      h2: {
        fontSize: '15px',
      },
      h3: {
        fontSize: '18px',
      },
    },
  },
};

export default theme;
