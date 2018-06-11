# packer-build-templates
This repository is inspired by mwrock, StefanScherer, geerlingguy and others. Also some content taken from them.

Using provisioner like BoxStarter, Ansible, Chef and others in the build process add complexity to the user who just wants to quickly build a box to try with different provisioner like above. 

Running updates on the boxes specially Windows and failing at the end with Packer and different issues just add frustration and log time wait to build the box. 

This repository tries to streamline the process. 

## Prerequisites

You need the following to run the template:

1. [Packer](https://packer.io/docs/installation.html) installed with a minimum version of 0.12.3. Also found to be work with 1.1.3.
2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Tested with 5.2.8


