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
