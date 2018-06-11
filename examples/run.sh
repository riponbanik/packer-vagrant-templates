# Build VMWare Image
packer build --only=vmware-iso centos-75.json

# Build VirtualBox Image
packer build --only=virtualbox-iso  centos-75.json

# Build Windows 2012 R2
packer build -var iso_url="iso/SW_DVD9_Windows_Svr_Std_and_DataCtr_2012_R2_64Bit_English_-3_MLF_X19-53588.ISO" -var iso_checksum=d4b28f350981a7c3306dd409b172aea10d8599ac -var iso_checksum_type=sha1 -only=virtualbox-iso windows_2012_r2.json