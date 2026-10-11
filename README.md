# NesBlaster
![Godot](https://img.shields.io/badge/Godot-478CBF?style=flat&logo=godotengine&logoColor=white)
![Stars](https://img.shields.io/github/stars/Zirenow/NesBlaster?style=rounded&color=yellow)
![Forks](https://img.shields.io/github/forks/Zirenow/NesBlaster?style=rounded&color=blue)
![Issues](https://img.shields.io/github/issues/Zirenow/NesBlaster?style=rounded&color=red)
![Last Commit](https://img.shields.io/github/last-commit/Zirenow/NesBlaster?style=rounded&color=purple)
![Repo Size](https://img.shields.io/github/repo-size/Zirenow/NesBlaster?style=rounded&color=green)
![License](https://img.shields.io/github/license/Zirenow/NesBlaster?style=rounded&color=orange)
## What is this?
*NesBlaster* is a simple tool that can be used to corrupt games and other software

## What is corrupting?
Its the act of purposely breaking game to produce often funny, interesting or even creepy bugs.
Such acts are done using hex editors or specialised software like this one.
You can learn more on [Corrupt wiki](https://corrupt.wiki/)

## 🔨 Installation
You can either clone and build this project yourself or just download the executable.
Whatever works for you.

## 📄 How to use
The interface was designed to be as straight forward as possible. But i will explain some parts that might be confusing
#### Range
This is the slice of file to be affected. You can detect the end of file by toggling `Detect EOF`
### Engine
This is the method of scrambling bytes. Currently you can choose:
- randomize byte value between `0` to `255`
- flip byte
- shift byte left by one

## 🎮 Tested 3rd party emulators
- Fceux 2.6.5
