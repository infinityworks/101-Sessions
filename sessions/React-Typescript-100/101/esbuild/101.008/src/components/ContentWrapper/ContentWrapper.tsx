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
