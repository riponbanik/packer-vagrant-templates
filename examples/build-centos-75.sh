# Build VMWare Image
packer build --only=vmware-iso centos-75.json

# Build VirtualBox Image
packer build --only=virtualbox-iso  centos-75.json