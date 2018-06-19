# Build Windows 2016 for virtualbox
packer build -var iso_url="iso/en_windows_server_version_1803_x64_dvd_12063476.iso" `
             -var iso_checksum=7b389be8e691984b913c1985cbf35732a525f859 `
             -var iso_checksum_type=sha1 `
             -only=virtualbox-iso windows_server_1803.json `

# Build box only particular type e.g. virtualbox
packer build -only=virtualbox=iso windows_server_1803.json

# Build virtualbox with specific name - will create own outout directory
packer build  -only=windows-server-1803-virtualbox windows_server_1803.json