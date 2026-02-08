# KRatio
KRatio is a simple KDE / Kirigami utility for calculating dilution ratios.

It answers questions like:
> "I need 1 gallon total at a 256:1 ratio - how much concentrate do I need?"

KRatio is designed to be fast, clear, and practical. 


## Features
- Calculate concentrate amounts from a total volume and ratio
- Supports common volume units (gallons, liters, milliliters)
- Clean, single-page Kirigami interface


## Screenshots
*(Coming soon)*


## Build Requirements
- Qt 6
- KDE Frameworks 6 (Kirigami, I18n, IconThemes)
- CMake >= 3.20

See [KDE's official page for Kirigami dependencies](https://develop.kde.org/docs/getting-started/kirigami/setup-cpp/#linux)

## Building and Installing
```bash
git clone https://github.com/jtsimon93/KRatio.git
cd kratio

cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$HOME/.local
cmake --build build
cmake --install build
```

After installing, the application should appear in your launcher. 

### Run Without Installing
Alternatively, you can run the application without installing it. 

```bash
git clone https://github.com/jtsimon93/KRatio.git
cd kratio

cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$HOME/.local
cmake --build build
build/bin/kratio
```

## Packaging
Flatpak support is planned but not yet implemented.

## Contributing
Contributions are welcome. Please open an issue to discuss. Submit a PR to have any improvements reviewed. 
