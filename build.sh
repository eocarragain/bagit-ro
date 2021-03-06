#!/bin/sh
set -e
cd example1
#curl https://gist.githubusercontent.com/anonymous/7fe620279ea4988a5a1e/raw/e55d9ea6af35ea67cfaf47b03a2b71f9026325fd/external.txt > data/external.txt

md5sum data/* > manifest-md5.txt
sha1sum data/* > manifest-sha1.txt
rm -f data/external.txt # :)

find metadata -type f | xargs md5sum > tagmanifest-md5.txt
find metadata -type f | xargs sha1sum > tagmanifest-sha1.txt

cd ..
BAGIT=example1.bagit.zip
rm -f $BAGIT
zip -q -r $BAGIT example1
echo Built BagIt $BAGIT


BUNDLE=example1.bundle.zip
rm -f $BUNDLE
cd example1
echo -n application/vnd.wf4ever.robundle+zip > mimetype
mv metadata .ro
zip -q -0 -X ../$BUNDLE mimetype
mv .ro metadata
rm mimetype
zip -q -r ../$BUNDLE .
echo Built RO Bundle $BUNDLE
cd ..
