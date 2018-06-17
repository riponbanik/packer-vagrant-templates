# Build Windows 2016 for virtualbox
packer build -var iso_url="iso/en_windows_server_2016_updated_feb_2018_x64_dvd_11636692.iso" -var iso_checksum=7adc82e00f1367b43897bb969a75bbf96d46f588 -var iso_checksum_type=sha1 -only=virtualbox-iso windows_2016_dc.json

# Build box only particular type e.g. virtualbox
packer build -only=virtualbox=iso windows_2016_core.json

# Build virtualbox with specific name - will create own outout directory
packer build  -only=windows-2016-core-virtualbox windows_2016_core.json