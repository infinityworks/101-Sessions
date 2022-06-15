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
