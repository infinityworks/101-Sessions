# Dev Container

If you want to use the Devcontainer

1. Check out the code from GitHub
2. Make an empty `.aws` and `.ssh` folder in your home directory
3. Install Docker
4. Open the `101` folder in `VSCODE`
5. Install the MS Remote Containers extension <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>
6. Choose the Open in Container and let the Docker build (5-6 minutes)

## Mac Setup

Prerequisites:

- Docker
- VSCode
- [VSCode Remote Containers plugin](https://code.visualstudio.com/docs/remote/containers#_installation)

If you receive a message saying `A mount config is invalid. Make sure it has the right format and as source folder that exists on the machine where the Docker daemon is running.` check that you have the following folders `~/.aws` and `~/.ssh` - if either of these are missing you will need to create them with `mkdir` or via the Finder.

## Ubuntu Setup

Install Docker (Ubuntu)

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Add yourself to docker users

```bash
sudo usermod -aG docker steven
docker run hello-world
```

Test it

```bash
sudo docker run hello-world
```

Reboot, then test your own user

```bash
sudo reboot now
```

```bash
docker run hello-world
```

## Debugging/FAQs

- Current configuration of devcontainer mounts in credentials from the parent system's ~/.aws and ~/.ssh directories. If these do not exist, `docker run` command that runs on container startup will fail (due to not being able to mount these directories into the container).
