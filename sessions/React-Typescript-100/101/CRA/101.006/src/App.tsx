import React from 'react';
import { MantineProvider } from '@mantine/core';
import defaultTheme from './themes/default';
import Header from './components/Header/Header';
import Footer from './components/Footer/Footer';
import Home from './pages/Home/Home';

export default function App() {
  return (
    <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
      <Header />
      <Home />
      <Footer />
    </MantineProvider>
  );
}
