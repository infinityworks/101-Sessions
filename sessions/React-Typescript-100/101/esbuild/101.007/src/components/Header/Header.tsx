import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEarth } from '@fortawesome/free-solid-svg-icons';
import { Center, Title } from '@mantine/core';

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

export default Header;
