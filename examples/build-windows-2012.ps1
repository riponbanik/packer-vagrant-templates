# Build Windows 2012 R2 with different iso
packer build -var iso_url="iso/SW_DVD9_Windows_Svr_Std_and_DataCtr_2012_R2_64Bit_English_-3_MLF_X19-53588.ISO" `
             -var iso_checksum=d4b28f350981a7c3306dd409b172aea10d8599ac  `
             -var iso_checksum_type=sha1 windows-2012r2.json

# Build box only particular type e.g. virtualbox
packer build -only=virtualbox=iso windows-2012r2.json

# Build virtualbox with specific name - will create own outout directory
packer build -only=windows-2012R2-std-virtualbox windows-2012r2.json 
