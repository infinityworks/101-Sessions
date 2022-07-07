import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faFacebook, faTwitter } from '@fortawesome/free-brands-svg-icons';
import { Center, Box, Text } from '@mantine/core';
import ContentWrapper from '../ContentWrapper/ContentWrapper';

export default function Footer() {
  return (
    <Box px="md" py="lg" sx={{ backgroundColor: '#3B3B3B', color: '#fff' }}>
      <ContentWrapper>
        <>
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
        </>
      </ContentWrapper>
    </Box>
  );
}
