import { AppShell, MantineProvider } from '@mantine/core';
import { Route, Routes } from 'react-router-dom';
import React from 'react';
import Footer from './components/Footer/Footer';
import Header from './components/Header/Header';
import Home from './pages/Home/Home';
import './styles.module.css';
import defaultTheme from './themes/default';
import LogIn from './pages/LogIn/LogIn';

export default function App() {
  return (
    <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
      <AppShell
        padding="md"
        header={<Header />}
        footer={<Footer />}
      >
        <Routes>
          <Route path="/log-in" element={<LogIn />} />
          <Route path="/" element={<Home />} />
        </Routes>
      </AppShell>
    </MantineProvider>
  );
}
