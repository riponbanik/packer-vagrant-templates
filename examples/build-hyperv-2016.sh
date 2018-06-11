# Build virtualbox image
packer build -var iso_url="iso/14393.0.161119-1705.RS1_REFRESH_SERVERHYPERCORE_OEM_X64FRE_EN-US.ISO" -var iso_checksum=53e2f01dc4077192a85f60f8d2ffb02189074e19b25f990cbe9eb767328d3fb6 -var iso_checksum_type=sha256 -only=windows-2016-amd64-virtualbox windows_2016_hyperv.json
