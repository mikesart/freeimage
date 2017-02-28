; View HDR images
pfsv *.hdr

; convert exr to hdr
pfsin blah.exr | pfsout blah.hdr

; View all OpenEXR images, resize if larger than 512x512
pfsin *.exr | pfssize --maxx 512 --maxy 512 | pfsview

pfsin BrightRings.hdr | pfsglview
