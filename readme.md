# packer-build-templates
This repository is inspired by mwrock, StefanScherer, geerlingguy and others. Also some content taken from them.

Using provisioner like BoxStarter, Ansible, Chef and others in the build process add complexity to the user who just wants to quickly build a box to try with different provisioner like above. 

Running updates on the boxes specially Windows and failing at the end with Packer and different issues just add frustration and log time wait to build the box. 

This repository tries to streamline the process. 

## Prerequisites

You need the following to run the template:

1. [Packer](https://packer.io/docs/installation.html) installed with a minimum version of 0.12.3. Also found to be work with 1.1.3.
2. [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Tested with 5.2.8


### Windows Editions

All Windows Server versions are defaulted to the Server Standard edition. You
can modify this by editing the Autounattend.xml file, changing the
`ImageInstall`>`OSImage`>`InstallFrom`>`MetaData`>`Value` element (e.g. to
Windows Server 2012 R2 SERVERDATACENTER).

To retrieve the correct ImageName from an ISO file use the following two commands.

```
PS C:\> Mount-DiskImage -ImagePath C:\iso\Windows_InsiderPreview_Server_2_16237.iso
PS C:\> Get-WindowsImage -ImagePath e:\sources\install.wim

ImageIndex       : 1
ImageName        : Windows Server 2016 SERVERSTANDARDACORE
ImageDescription : Windows Server 2016 SERVERSTANDARDACORE
ImageSize        : 7,341,507,794 bytes

ImageIndex       : 2
ImageName        : Windows Server 2016 SERVERDATACENTERACORE
ImageDescription : Windows Server 2016 SERVERDATACENTERACORE
ImageSize        : 7,373,846,520 bytes
```

### Product Keys

The `Autounattend.xml` files are configured to work correctly with trial ISOs
(which will be downloaded and cached for you the first time you perform a
`packer build`). If you would like to use retail or volume license ISOs, you
need to update the `UserData`>`ProductKey` element as follows:

* Uncomment the `<Key>...</Key>` element
* Insert your product key into the `Key` element

If you are going to configure your VM as a KMS client, you can use the product
keys at http://technet.microsoft.com/en-us/library/jj612867.aspx. These are the
default values used in the `Key` element.

### Using existing ISOs

If you have already downloaded the ISOs or would like to override them, set
these additional variables:

* iso_url - path to existing ISO
* iso_checksum - md5sum of existing ISO (if different)
* iso_checksum_type - sha1 (default)

```
packer build -var 'iso_url=./server2016.iso' .\windows_2016.json
```

### Artifact

If you do not want to keep the artifact (.ovf) created by the box (which is helpful to use with other hypervisor e.g. VMWare)
change to following in the template. Using variable for boolean does not seem to work at this moment.

keep_input_artifact": false

### Windows Updates

The scripts in this repo will install all Windows updates – by default – during
Windows Setup. This is a _very_ time consuming process, depending on the age of
the OS and the quantity of updates released since the last service pack. You
might want to do yourself a favor during development and disable this
functionality, by commenting out the `WITH WINDOWS UPDATES` section and
uncommenting the `WITHOUT WINDOWS UPDATES` section in `Autounattend.xml`:

```xml
<!-- WITHOUT WINDOWS UPDATES -->
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1 -AutoStart</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<!-- END WITHOUT WINDOWS UPDATES -->
<!-- WITH WINDOWS UPDATES -->
<!--
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c a:\microsoft-updates.bat</CommandLine>
    <Order>98</Order>
    <Description>Enable Microsoft Updates</Description>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\openssh.ps1</CommandLine>
    <Description>Install OpenSSH</Description>
    <Order>99</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
<SynchronousCommand wcm:action="add">
    <CommandLine>cmd.exe /c C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File a:\win-updates.ps1</CommandLine>
    <Description>Install Windows Updates</Description>
    <Order>100</Order>
    <RequiresUserInput>true</RequiresUserInput>
</SynchronousCommand>
-->
<!-- END WITH WINDOWS UPDATES -->
```

Doing so will give you hours back in your day, which is a good thing.

### WinRM

These boxes use WinRM. There is no OpenSSH installed.

### Hyper-V Support

If you are running Windows 10, Windows Server 2016 or later, then you can also use these packerfiles to build
a Hyper-V virtual machine. I have the ISO already downloaded to save time, and
only have Hyper-V installed on my laptop, so I run:

```
packer build --only hyperv-iso -var 'hyperv_switchname=Ethernet' -var 'iso_url=./server2016.iso' .\windows_2016_docker.json
```

You then can use this box with Vagrant to spin up a Hyper-V VM.

#### Generation 2 VMs

Some of these images use Hyper-V "Generation 2" VMs to enable the latest features and faster booting. However, an extra manual step is needed to put the needed files into ISOs because Gen2 VMs don't support virtual floppy disks.

* `windows_server_insider.json`
* `windows_server_insider_docker.json`
* `windows_10_insider.json`

Before running `packer build`, be sure to run `./make_unattend_iso.ps1` first. Otherwise the build will fail on a missing ISO file

```none
hyperv-iso output will be in this color.

1 error(s) occurred:

* Secondary Dvd image does not exist: CreateFile ./iso/windows_server_insider_unattend.iso: The system cannot find the file specified.
```

### Using .box Files With Vagrant

The generated box files include a Vagrantfile template that is suitable for use
with Vagrant 1.7.4+, but the latest ersion is always recommended.

Example Steps for Hyper-V:

```
vagrant box add windows_2016_docker windows_2016_docker_hyperv.box
vagrant init windows_2016_docker
vagrant up --provider hyperv
```