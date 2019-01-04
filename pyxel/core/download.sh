#!/bin/bash

# How to use
# 1. Execute this script on Mac with Homebrew
# 2. Ececute this script on Ubuntu Linux

SCRIPT_DIR=$(cd $(dirname $0);pwd)

SDL2_INCDIR=$SCRIPT_DIR/include/SDL2
SDL2_LIBDIR=$SCRIPT_DIR/lib

MINGW_SDL2_URL="https://www.libsdl.org/release/SDL2-devel-2.0.9-mingw.tar.gz"
MINGW_SDL2_IMAGE_URL="https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.4-mingw.tar.gz"

cd $SCRIPT_DIR

if [ $(uname) = "Darwin" ]; then
  rm -rf $SDL2_INCDIR $SDL2_LIBDIR
  mkdir -p $SDL2_INCDIR $SDL2_LIBDIR

  brew reinstall sdl2 sdl2_image
  cp /usr/local/include/SDL2/*.h $SDL2_INCDIR
  cp /usr/local/lib/libSDL2.a $SDL2_LIBDIR/libSDL2_darwin_amd64.a
  cp /usr/local/lib/libSDL2_image.a $SDL2_LIBDIR/libSDL2_image_darwin_amd64.a
  brew uninstall sdl2 sdl2_image

  rm -rf temp
  mkdir -p temp
  cd temp

  curl -L $MINGW_SDL2_URL -o sdl2.tar.gz
  tar xzf sdl2.tar.gz
  cd SDL2-*
  pwd
  cp i686-w64-mingw32/lib/libSDL2.a $SDL2_LIBDIR/libSDL2_windows_386.a
  cp i686-w64-mingw32/lib/libSDL2main.a $SDL2_LIBDIR/libSDL2main_windows_386.a
  cp x86_64-w64-mingw32/lib/libSDL2.a $SDL2_LIBDIR/libSDL2_windows_amd64.a
  cp x86_64-w64-mingw32/lib/libSDL2main.a $SDL2_LIBDIR/libSDL2main_windows_amd64.a
  cd ..

  curl -L $MINGW_SDL2_IMAGE_URL -o sdl2_image.tar.gz
  tar xzf sdl2_image.tar.gz
  cd SDL2_image-*
  cp i686-w64-mingw32/lib/libSDL2_image.a $SDL2_LIBDIR/libSDL2_image_windows_386.a
  cp x86_64-w64-mingw32/lib/libSDL2_image.a $SDL2_LIBDIR/libSDL2_image_windows_amd64.a
  cd ..

  cd ..
  rm -rf temp
elif [ $(uname) = "Linux" ]; then
  sudo apt install libsdl2-dev libsdl2-image-dev
  cp /usr/lib/x86_64-linux-gnu/libSDL2.a $SDL2_LIBDIR/libSDL2_linux_amd64.a
  cp /usr/lib/x86_64-linux-gnu/libSDL2_image.a $SDL2_LIBDIR/libSDL2_image_linux_amd64.a
  sudo apt remove libsdl2-dev libsdl2-image-dev
fi