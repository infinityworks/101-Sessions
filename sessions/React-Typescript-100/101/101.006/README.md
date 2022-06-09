First page & external component libs

Add new file `src/pages/Home/Home.tsx`
    import React from 'react';

    export default function Home() {
        return (
            <>
            <h1>Home</h1>
            <p>This is the home page</p>
            </>
        );
    }

Note: export default is inline

Update ``App.tsx` file:
    import Home from './pages/Home/Home';

    export default function App() {
        return (
            <>
            <Header />
            <Home />
            <Footer />
            </>

        );
    }


Using third party Libs - https://mantine.dev/getting-started/
In the terminal `yarn add @mantine/hooks @mantine/core`

Using https://mantine.dev/theming/mantine-provider/
Add Provider to `App.tsx`
    import { MantineProvider } from '@mantine/core';

    <MantineProvider theme={{ fontFamily: 'Open Sans' }} withGlobalStyles withNormalizeCSS>
      <Header />
      <Home />
      <Footer />
    </MantineProvider>

Create file `themes/default.ts`:
    import { MantineThemeOverride } from '@mantine/core';

    const theme: MantineThemeOverride = {
    colorScheme: 'light',
    primaryColor: 'orange',
    defaultRadius: 0,
    };

    export default theme;

Remove from styles.module.css
    h1 {
        font-size: 25px;
        font-weight: 600;
    }

Add to `themes/default.ts`:
    fontFamily: 'Open Sans',
    breakpoints: {
        xs: 0,
        sm: 480,
        md: 640,
        lg: 960,
        xl: 1200,
    },
    ,
    spacing: {
        xs: 4,
        sm: 8,
        md: 16,
        lg: 24,
        xl: 32,
    },
    fontFamily: 'Open Sans',
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

Note: when adding the text above show the way typescript works when you add a type to variable. Use control + space on mac then highlight the headings to show the shape of the object. 
Then for sizes in headings use command + click on MantineThemeOverride then repeat on HeadingStyle

Add theme to `App.tsx`
    import theme from './themes/default';
    <MantineProvider theme={theme} withGlobalStyles withNormalizeCSS>

Update `Home.tsx`
    export default function Home() {
    return (
        <>
            <Title order={1}>Home</Title>
            <Text>This is the home page</Text>
        </>
    );
    }

Look at AppShell https://mantine.dev/core/app-shell/ --Mobile first design (more in a later lesson)
Add to `App.tsx`
    <MantineProvider theme={defaultTheme} withGlobalStyles withNormalizeCSS>
        <AppShell
            padding="md"
            header={<Header />}
            footer={<Footer />}
        >
            <Home />
        </AppShell>
    </MantineProvider>

Task update the Header and Footer to use Mat-ui
Give 5 minutes then go through Header
    function Header() {
        return (
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
        );
    }

Footer solution:
    function Footer() {
        return (
            <Box px="md" py="lg" sx={{ backgroundColor: '#3B3B3B', color: '#fff' }}>
            <Center>
                <a href="www.facebook.com" target="_blank" aria-label="facebook" style={{ marginRight: '12px' }}>
                <FontAwesomeIcon icon={faFacebook} size="2x" color="#fff" />
                </a>
                <a href="www.twitter.com" target="_blank" aria-label="twitter">
                <FontAwesomeIcon icon={faTwitter} size="2x" color="#fff" />
                </a>
            </Center>
            <Text pt="md">
                A seven-day forecast can accurately predict the weather about 80 percent of the time
                and a five-day forecast can accurately predict the weather approximately 90 percent
                of the time. However, a 10-day or longer forecast is only right about half the time.
            </Text>
            </Box>
        );
    }

Create file in `components/ContentWrapper/ContentWrapper.tsx`
    import { Container } from '@mantine/core';
    import React from 'react';

    interface ContentWrapperProps {
        children: JSX.Element;
    }

    export default function ContentWrapper({ children }: ContentWrapperProps) {
        return (
            <Container size={1200}>
            {children}
            </Container>
        );
    }

Add to Footer and Main Page;

Create Home page for next lesson
    export default function Home() {
        return (
            <ContentWrapper>
            <>
                <Title pb="md" order={1}>Check the weather</Title>
                <Text>Either login to check your saved locations or search below</Text>
                <TextInput py="md" label="Location search" description="Enter a postcode or city name below" />
            </>
            </ContentWrapper>
        );
    }