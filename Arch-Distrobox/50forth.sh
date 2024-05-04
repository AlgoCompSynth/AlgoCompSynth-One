#! /usr/bin/env bash

echo "Installing old gforth"
yay --sync --refresh --noconfirm \
  gforth

echo ""
echo "Installing latest gforth"
echo "You will need to confirm removal of old gforth"
sleep 10
yay --sync --refresh \
  gforth-git

echo ""
echo "Installing pforth"
yay --sync --refresh --needed --noconfirm \
  pforth-git

echo ""
echo "Installing e4thcom"
yay --sync --refresh --needed --noconfirm \
  e4thcom

echo ""
echo "Installing ficl"
yay --sync --refresh --needed --noconfirm \
  ficl

echo ""
echo "Installing 4th"
yay --sync --refresh --needed --noconfirm \
  4th

echo "Finished"
