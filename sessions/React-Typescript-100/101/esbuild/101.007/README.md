Adding routing and sign in page

In terminal: `yarn add react-router-dom`

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
                    to="/log-in"
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

Add Navbar to `Header.tsx`
    import React from 'react';
    import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
    import { faEarth } from '@fortawesome/free-solid-svg-icons';
    import { Box, Center, Title } from '@mantine/core';
    import Navbar from '../NavBar/Navbar';

    export default function Header() {
        return (
            <Box>
            <Center
                px="md"
                py="lg"
                sx={{
                color: '#fff',
                backgroundColor: '#005985',
                }}
            >
                <FontAwesomeIcon icon={faEarth} size="2x" />
                <Title pl="sm">How is the weather?</Title>
            </Center>
            <Navbar />
            </Box>
        );
    }

Add routing to `App.tsx`
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

Add browser to `index.tsx`
    import { BrowserRouter } from 'react-router-dom';
    <BrowserRouter>
      <App />
    </BrowserRouter>

Now we can navigate to the login page 

Update file `pages/Login/Login.tsx`
    import { Button, TextInput, Title } from '@mantine/core';
    import React from 'react';
    import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

    export default function LogIn() {
        return (
            <ContentWrapper>
            <>
                <Title pb="md" order={1}>Log In</Title>
                <TextInput pt="md" pb="xs" label="Username" />
                <TextInput pb="md" label="Password" />
                <Button>Log in</Button>
            </>
            </ContentWrapper>
        );
    }

This login page can't be refreshed while in dev mode this is because
If you hit the home page you'll get / and the HTML page containing the HTML layout, and links to the React JavaScript bundles.
Then the JavaScript will be loaded into the main element or whatever, and the app works great. react-router takes over the client side routing, and even changes the URL so that it looks like it's working. (edited) 
However, there's no /log-in directory, so the web server has no idea what's going on.

