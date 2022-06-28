Adding routing and sign in page

In terminal: `yarn add react-router-dom @types/react-router-dom`

Add new file `pages/Login/Login.tsx`
    import React from 'react';

    export default function LogIn() {
        return (
            <h1>Login</h1>
        );
    }

Add new file `components/Navbar/Navbar.tsx`
    import { Anchor, Box, Text } from '@mantine/core';
    import { Link } from 'react-router-dom';
    import React from 'react';
    import ContentWrapper from '../ContentWrapper/ContentWrapper';

    export default function Navbar() {
        return (
            <Box
            py="md"
            sx={{
                backgroundColor: '#1cb5ff',
                color: 'white',
            }}
            >
            <ContentWrapper>
                <Box sx={{ display: 'flex', justifyContent: 'space-between' }}>
                <Box>
                    <Text>Place holder for other links</Text>
                </Box>
                <Box>
                    <Anchor
                    component={Link}
                    to="/login"
                    sx={{ color: 'white', height: '100%' }}
                    >
                    Log in
                    </Anchor>
                </Box>

                </Box>
            </ContentWrapper>
            </Box>
        );
    }

Add Navbar to `App.tsx`

Add routing to `App.tsx`
    import React from 'react';
    import { MantineProvider } from '@mantine/core';
    import { Route, Routes } from 'react-router-dom';
    import defaultTheme from './themes/default';
    import Header from './components/Header/Header';
    import Footer from './components/Footer/Footer';
    import Home from './pages/Home/Home';
    import Navbar from './components/Navbar/Navbar';
    import LogIn from './pages/Login/Login';

    export default function App() {
        return (
            <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
            <Header />
            <Navbar />
            <Routes>
                <Route path="/log-in" element={<LogIn />} />
                <Route path="" element={<Home />} />
            </Routes>
            <Footer />
            </MantineProvider>
        );
    }

Add browser to `index.tsx`
    import { BrowserRouter } from 'react-router-dom';
    <BrowserRouter>
      <App />
    </BrowserRouter>

Now we can navigate to the login page;

Update file `pages/Login/Login.tsx`
    import { Button, TextInput, Title } from '@mantine/core';
    import React from 'react';
    import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

    export default function LogIn() {
        return (
            <ContentWrapper>
                <Box my="md">
                    <Title pb="md" order={1}>Log In</Title>
                    <TextInput pt="md" pb="xs" label="Username" />
                    <TextInput pb="md" label="Password" />
                    <Button>Log in</Button>
                </Box>
            </ContentWrapper>
        );
    }

What Create React gives you and what is a single page app?
If you hit the home page you'll get / and the HTML page containing the HTML layout, and links to the React JavaScript bundles.
Then the JavaScript will be loaded into the main element and the app works great. 
React-router takes over the client side routing, and even changes the URL so that it looks like it's working. (edited) 
However, there's no /log-in directory, so the web server has no idea what's going on.

Task: add a contact us page.
`src/pages/ContactUs/ContactUs.tsx`
    import React from 'react';
    import {
    Box, Title,
    } from '@mantine/core';
    import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

    export default function LogIn() {
        return (
            <ContentWrapper>
            <Box my="md">
                <Title pb="md" order={1}>Contact Us</Title>
            </Box>
            </ContentWrapper>
        );
    }

Add <Route path="/log-in" element={<LogIn />} /> to App.tsx
Add to Navbar.tsx
    <Anchor
        component={Link}
        to="/contact-us"
        mr="md"
        sx={{ color: 'white', height: '100%' }}
        >
        Contact Us
    </Anchor>