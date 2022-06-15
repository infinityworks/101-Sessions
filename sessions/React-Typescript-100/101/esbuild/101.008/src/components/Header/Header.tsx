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
