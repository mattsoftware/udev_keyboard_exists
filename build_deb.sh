#!/usr/bin/env bash

VERSION=$1; shift
[ -z $VERSION ] && echo "You must provide a version" && exit 1
BUILD_FOLDER="build/udev_keyboard_exists-$VERSION"

echo "Building for version $VERSION (in $BUILD_FOLDER)"

mkdir -p "$BUILD_FOLDER"/etc/udev/rules.d
mkdir -p "$BUILD_FOLDER"/usr/bin

cp udev_keyboard_exists "$BUILD_FOLDER"/usr/bin/udev_keyboard_exists
cp udev_keyboard_exists.conf "$BUILD_FOLDER"/etc/udev_keyboard_exists.conf
cp 90-keyboard_exists.rules "$BUILD_FOLDER"/etc/udev/rules.d/90-keyboard_exists.rules
cp -a DEBIAN "$BUILD_FOLDER"/DEBIAN
sed -i 's|$VERSION|'$VERSION'|g' "$BUILD_FOLDER"/DEBIAN/control

chown root:root -R "$BUILD_FOLDER"/
dpkg-deb --build "$BUILD_FOLDER"

