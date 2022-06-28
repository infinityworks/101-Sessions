State and validation

Lets make the login form come to life.
NOTE: there are other ways to do forms but this is a way to teach hooks at the same time.

Add state for username:
    const [username, setUsername] = useState('');
    console.log(setUsername); //To deal with the build break

    Update line below
    <TextInput pt="md" pb="xs" label="Username" value={username} />

But now we can't type in the box but we can set it's value
    const [username, setUsername] = useState('fred');

Now we add the function to get the state to change
Update line 
    <TextInput
        pt="md"
        pb="xs"
        label="Username"
        value={username}
        onChange={(event) => setUsername(event.currentTarget.value)}
    />

Lesson: Have ago at setting up the next one
    const [password, setPassword] = useState('');

    <TextInput
        pb="md"
        label="Password"
        value={password}
        onChange={(event) => setPassword(event.currentTarget.value)}
    />

Test the hooks by adding
    <Button onClick={() => console.log({ username, password })}>Log in</Button>

What about validation?
    <Button onClick={() => {
          let error = false;

          if (username.length < 3) {
            error = true;
            setUsernameError('Must be greater than 2 chars');
          }

          if (!error) {
            console.log({ username, password });
          }
        }}
    >

    <TextInput
        pt="md"
        pb="xs"
        label="Username"
        value={username}
        error={usernameError}
        onChange={(event) => setUsername(event.currentTarget.value)}
    />

Now we are in a error state after the button is pressed;
    onChange={(event) => {
        const newUsername = event.currentTarget.value;
        if (usernameError && newUsername.length >= 3) {
            setUsernameError(null);
        }
        setUsername(newUsername);
    }}

But lets refine this incase we want to improve the validation
    function validateUsername(username: string): boolean {
        return username.length > 2;
    }

    if (usernameError && validateUsername(username)) {

    if (!validateUsername(username)) {

Have ago with password validation
    function validatePassword(password: string): boolean {
        return password.length > 0;
    }

    const [passwordError, setPasswordError] = useState<string | null>(null);

    error={passwordError}
    onChange={(event) => {
        const newPassword = event.currentTarget.value;
        if (passwordError && validateUsername(username)) {
            setPasswordError(null);
        }
        setPassword(newPassword);
    }}

    if (!validatePassword(password)) {
        error = true;
        setPasswordError('Is required');
    }

Lets cleanup
    add required to both TextInput

    Add type="password" to password input 

    import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
    import { faEye, faEyeSlash } from '@fortawesome/free-solid-svg-icons';

    const [displayPassword, setDisplayPassword] = useState(false);

    rightSection={(
        <Box sx={{ cursor: 'pointer' }}>
            <FontAwesomeIcon
            icon={displayPassword ? faEyeSlash : faEye}
            onClick={() => setDisplayPassword(!displayPassword)}
            />
        </Box>
    )}

Now lets undo or the good work and use a form instead
In the Terminal: `yarn add @mantine/form`

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
                    // {...form.getInputProps('username')}
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
                    // {...form.getInputProps('password')}
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
