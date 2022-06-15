import { AppShell, MantineProvider } from '@mantine/core';
import React from 'react';
import Footer from './components/Footer/Footer';
import Header from './components/Header/Header';
import Home from './pages/Home/Home';
import './styles.module.css';
import defaultTheme from './themes/default';

export default function App() {
  return (
    <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
      <AppShell
        padding="md"
        header={<Header />}
        footer={<Footer />}
      >
        <Home />
      </AppShell>
    </MantineProvider>
  );
}
