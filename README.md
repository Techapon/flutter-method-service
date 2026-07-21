# flutter-method-service


<img height="450" alt="flutter_service_tech_stack" src="https://github.com/user-attachments/assets/f3c3ebf2-5a99-4505-8033-92859ef3b5c4" />



# Flutter Method CLI

A simple tool that auto-creates folders and files for a Flutter project using **Clean Architecture**. It runs with PowerShell, and you can start it with one command using a `.bat` file.

This saves you time from making the same folders and files by hand every time you start a new project or add a new feature.

## Features

-   **Create the main file structure** — makes `config`, `core`, and `features` folders, plus starter files like `routes.dart`, `theme.dart`, `error.dart`, `network.dart`, `usecase.dart`, `injection_container.dart`, and more.
-   **Create a new feature structure** — makes folders for `domain`, `data`, and `presentation`, with starter files already named after your feature.
-   Won't create the same file or folder twice if it already exists.
-   Shows a tree view in the terminal while it creates everything, so you can see what's happening.

## Tech Stack

Part

What it does

**PowerShell**

The main script (`flutter_method_create_arch.ps1`). It creates folders/files, asks for your input, and shows the tree view.

**Batch Script (.bat)**

A shortcut file that runs the PowerShell script for you, so you don't need to type the full command every time.

**Windows Environment Variables (PATH)**

Lets you run the tool from any folder in the terminal, just by typing `flutter_arch`.

**Flutter / Dart (the end goal)**

This tool is not written in Flutter/Dart itself. It's a helper that builds `.dart` files and folders in the **Clean Architecture** style for your Flutter project.

> This tool only works on **Windows**, because it needs PowerShell and a `.bat` file. It does not work on macOS or Linux yet.

## What You Get

### 1) File Structure (menu option 1)

```
lib/
├─ config/
│  ├─ routes/
│  │  └─ routes.dart
│  └─ theme/
│     └─ theme.dart
├─ core/
│  ├─ constants/
│  │  └─ constants.dart
│  ├─ error/
│  │  └─ error.dart
│  ├─ network/
│  │  └─ network.dart
│  ├─ resources/
│  │  └─ data_state.dart
│  ├─ usecase/
│  │  └─ usecase.dart
│  └─ util/
│     └─ util.dart
├─ features/
└─ injection_container.dart

```

### 2) Feature Structure (menu option 2)

```
features/
└─ <feature_name>/
   ├─ domain/
   │  ├─ entities/
   │  │  └─ <feature_name>_entity.dart
   │  ├─ usecases/
   │  │  └─ <feature_name>_usecase.dart
   │  └─ repositories/
   │     └─ <feature_name>_repository.dart
   ├─ data/
   │  ├─ data_sources/
   │  │  └─ <feature_name>_data_sources.dart
   │  ├─ models/
   │  │  └─ <feature_name>_model.dart
   │  └─ repositories/
   │     └─ <feature_name>_repositories_impl.dart
   └─ presentation/
      ├─ controller/
      │  └─ <feature_name>_controller.dart
      ├─ pages/
      │  └─ <feature_name>_page.dart
      └─ widgets/
         └─ <feature_name>_build.dart

```

## Requirements

-   A Windows computer (this tool uses PowerShell and `.bat` files)
-   PowerShell (already built into Windows)
-   A Flutter project that already exists (with a `lib/` folder)

## Installation

1.  Save this project on your computer, for example:
    
    ```
    C:\Scripts\flutter_method_CLI\
    
    ```
    
2.  Make sure both files are in the same folder:
    
    -   `flutter_method_create_arch.ps1`
    -   `flutter_arch.bat`
3.  **Set the correct path in the `.bat` file.** Open `flutter_arch.bat` and change the path so it matches where you saved the `.ps1` file:
    
    ```bat
    @echo off
    powershell -ExecutionPolicy Bypass -File "C:\Scripts\flutter_method_CLI\flutter_method_create_arch.ps1"
    
    ```
    
4.  **Add the folder to your Environment Variables (PATH)** so you can run the command from anywhere:
    
    -   Open **Edit the system environment variables** > **Environment Variables**
    -   Find the `Path` variable (User or System) and click **Edit** > **New**
    -   Add the folder path where `flutter_arch.bat` is saved, e.g. `C:\Scripts\flutter_method_CLI\`
    -   Click OK, then open a new terminal window for the change to take effect
5.  Test it. Open a new terminal and type:
    
    ```
    flutter_arch
    
    ```
    
    If it works, you'll see a menu appear right away.
    

## Usage

1.  Open a terminal (cmd or PowerShell) and go to your Flutter project.
    
2.  **To create the main file structure** — you must be inside a folder named `lib`:
    
    ```
    cd your_flutter_project\lib
    flutter_arch
    
    ```
    
    Pick option `1`, then press Enter.
    
3.  **To create a new feature** — you must be inside a folder named `features` (this folder is created after running option 1):
    
    ```
    cd your_flutter_project\lib\features
    flutter_arch
    
    ```
    
    Pick option `2`, then type the feature name you want, like `login`, `home`, or `profile`.
    
4.  Type `o` to exit the program when you're done.
    

> ⚠️ **Note:** The script always checks your current folder name first. If you're not in `lib` (for option 1) or `features` (for option 2), it will show a warning and won't create any files.

## Project Structure (of this tool itself)

```
flutter_method_CLI/
├─ flutter_method_create_arch.ps1   # Main PowerShell script
├─ flutter_arch.bat                 # Shortcut to run the script
└─ README.md

```

## Troubleshooting

Problem

Cause / Fix

Nothing happens, or you see an execution policy error

Make sure you run `flutter_arch.bat`, not the `.ps1` file directly. The `.bat` file already sets `-ExecutionPolicy Bypass` for you.

Typing `flutter_arch` says "command not found"

Check that you added the folder to your `PATH`, and open a new terminal window after saving the change.

It says "Current path is not in 'lib'" or "'features'"

`cd` into the correct folder first before running the command.

The path in `.bat` doesn't match on another computer

Edit `flutter_arch.bat` and change the path to match where the `.ps1` file is saved on that computer.

## License

Add your license here, e.g. MIT

## Contributing

Want to add a new layer or change the file structure? Just edit the `$filesStructure` and `$featureStructure` variables inside `flutter_method_create_arch.ps1`.
