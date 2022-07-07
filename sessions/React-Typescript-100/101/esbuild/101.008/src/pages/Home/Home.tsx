import {
  Title, Text, TextInput,
} from '@mantine/core';
import React from 'react';
import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

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
