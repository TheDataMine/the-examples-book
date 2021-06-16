for f in "$@"
do
	if [[ $f == *.png ]]
	then
		/usr/local/bin/magick convert "$f" -filter Gaussian -sharpen 0x3 -resize 50% "$f"
		/usr/local/bin/pngquant 64 --skip-if-larger --strip --ext=.png --force "$f"
		/usr/local/bin/zopflipng -y "$f" "$f"
		/usr/local/bin/cwebp -q 30 "$f" -o "${f%.*}.webp"
		rm "$f"
	fi
done