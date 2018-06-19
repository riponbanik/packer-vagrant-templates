# Build virtualbox image with different iso 
packer build -var iso_url="iso/14393.0.161119-1705.RS1_REFRESH_SERVERHYPERCORE_OEM_X64FRE_EN-US.ISO" `
             -var iso_checksum=e6d2668e7b6681333debd499bd5734c84bc0a86d `
             -var iso_checksum_type=sha1 hyperv_2016.json

# Build box only particular type e.g. virtualbox
packer build -only=virtualbox=iso hyperv_server_2016.json

# Build virtualbox with specific name - will create own outout directory
packer build -only=hyperv-server-2016-virtualbox hyperv_server_2016.json
