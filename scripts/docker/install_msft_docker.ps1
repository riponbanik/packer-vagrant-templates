# https://docs.docker.com/install/windows/docker-ee/#use-a-script-to-install-docker-ee

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name Docker -ProviderName DockerMsftProvider -Force
(Install-WindowsFeature Containers).RestartNeeded
Restart-Computer -Force

# Test docker installation
# docker container run hello-world:nanoserver

# Update docker
# Install-Package -Name docker -ProviderName DockerMsftProvider -Update -Force