import React from 'react';
import { MantineProvider } from '@mantine/core';
import { Route, Routes } from 'react-router-dom';
import defaultTheme from './themes/default';
import Header from './components/Header/Header';
import Footer from './components/Footer/Footer';
import Home from './pages/Home/Home';
import Navbar from './components/Navbar/Navbar';
import LogIn from './pages/Login/Login';
import ContactUs from './pages/ContactUs/ContactUs';

export default function App() {
  return (
    <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
      <Header />
      <Navbar />
      <Routes>
        <Route path="/log-in" element={<LogIn />} />
        <Route path="/contact-us" element={<ContactUs />} />
        <Route path="/" element={<Home />} />
      </Routes>
      <Footer />
    </MantineProvider>
  );
}
