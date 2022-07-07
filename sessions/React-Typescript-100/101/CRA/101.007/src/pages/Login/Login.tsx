import React from 'react';
import {
  Box, Button, TextInput, Title,
} from '@mantine/core';
import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

export default function LogIn() {
  return (
    <ContentWrapper>
      <Box my="md">
        <Title order={1}>Log In</Title>
        <TextInput pt="md" pb="xs" label="Username" />
        <TextInput pb="md" label="Password" />
        <Button>Log in</Button>
      </Box>
    </ContentWrapper>
  );
}
