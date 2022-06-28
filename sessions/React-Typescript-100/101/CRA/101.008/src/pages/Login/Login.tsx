import React, { useState } from 'react';
import {
  Box, Button, Group, TextInput, Title,
} from '@mantine/core';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faEye, faEyeSlash } from '@fortawesome/free-solid-svg-icons';
import { useForm } from '@mantine/form';
import ContentWrapper from '../../components/ContentWrapper/ContentWrapper';

function validateUsername(username: string) {
  return username.length > 2 ? null : 'Must be greater than 2 chars';
}

// function validatePassword(password: string): boolean {
//   return password.length > 0;
// }

export default function LogIn() {
  const [displayPassword, setDisplayPassword] = useState(false);

  const form = useForm({
    initialValues: {
      username: '',
      password: '',
    },

    validate: {
      username: (value) => validateUsername(value),
    },
  });

  return (
    <ContentWrapper>
      <Box my="md">
        <Title order={1}>Log In</Title>
        <form onSubmit={form.onSubmit((values) => console.log(values))}>
          <TextInput
            required
            label="Username"
            // eslint-disable-next-line react/jsx-props-no-spreading
            {...form.getInputProps('username')}
            pt="md"
            pb="sm"
          />
          <TextInput
            required
            label="Password"
            type={displayPassword ? 'text' : 'password'}
            rightSection={(
              <Box sx={{ cursor: 'pointer' }}>
                <FontAwesomeIcon
                  icon={displayPassword ? faEyeSlash : faEye}
                  onClick={() => setDisplayPassword(!displayPassword)}
                />
              </Box>
            )}
            // eslint-disable-next-line react/jsx-props-no-spreading
            {...form.getInputProps('password')}
            pb="md"
          />

          <Group position="right" mt="md">
            <Button type="submit">Submit</Button>
          </Group>
        </form>
      </Box>
    </ContentWrapper>
  );
}
