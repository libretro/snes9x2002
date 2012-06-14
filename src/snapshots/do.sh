#!/bin/bash

FILE=$(date +%Y%m%d-%k%M)
zip -9 -r pocketsnes-$FILE ../* -x \*.o \*.gpe \*.zip \*~
