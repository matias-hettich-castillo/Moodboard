# MoodBoard

A simple Bash script that generates aesthetic moodboards from a random selection of images using ImageMagick.

The script automatically:

- Selects random images from the current directory.
- Creates a thumbnail collage.
- Generates a blurred ambient background.
- Composites everything into a clean final image.

## Requirements

This project includes two versions of the script, depending on the installed ImageMagick release:

### MoodBoard (ImageMagick v6)

Compatible with systems using the classic `montage` and `convert` commands.

### MoodBoard (ImageMagick v7)

Compatible with ImageMagick 7, which uses the `magick` command-line interface.

Choose the version that matches your installed ImageMagick release.

## Supported image formats

- JPG
- JPEG
- PNG
- WEBP

## Usage

```bash
./moodboard.sh <columns> <rows>
```

Example:

```bash
./moodboard.sh 5 4
```

This generates a 5×4 moodboard using 20 randomly selected images.

The final image is saved as:

```
Output/moodboard.jpg
```

## Example workflow

```
images/
    image1.jpg
    image2.png
    image3.webp
    ...

./moodboard.sh 6 5
```

Produces:

```
Output/moodboard.jpg
```

## Author

Matias H. Castillo

## License

MIT License.
