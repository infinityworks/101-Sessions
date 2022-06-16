import { faEarth } from '@fortawesome/free-solid-svg-icons';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { Center, Title } from '@mantine/core';
import React from 'react';

export default function Header() {
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
