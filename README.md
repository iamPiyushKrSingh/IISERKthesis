# IISER Kolkata MS Thesis Template

A modern, elegant, and fully-featured LaTeX template designed for MS and PhD theses at the Indian Institute of Science Education and Research (IISER) Kolkata. 

This template is meticulously optimized for physics and mathematics formatting but is flexible enough for any department.

## ✨ Features

- **Beautiful Theorem Environments**: Custom, dynamically-referenced `Theorem`, `Lemma`, `Definition`, and `Remark` environments built with `tcolorbox`.
- **Advanced Code Blocks**: Syntax-highlighted code environments powered by `minted`, configured with uncopyable line numbers to allow easy code copy-pasting by readers.
- **Automated Frontmatter**: Generates title pages, declarations, certificates, acknowledgements, and abstracts automatically from your metadata.
- **Smart Toggles**: Enable or disable the List of Figures, List of Tables, Nomenclature, List of Listings, and Todo list directly from the `\documentclass` options.
- **Built-in `todonotes`**: Leave yourself inline or margin notes as you write, which compile into a handy "Todo list" index at the front of the document.
- **Math & Physics Ready**: Comes pre-loaded with `physics`, `mathtools`, `slashed`, `tensor`, and custom macros (e.g. `\ket`, `\pdv`).
- **Optimized Compilation**: Stripped down `tcolorbox` library imports and pre-configured for lightning-fast compilation times.

## 🚀 Quick Start

1. **Clone or Download** this repository.
2. **Edit Metadata**: Open `main.tex` and fill in your personal details (Title, Name, Roll No, Supervisor, etc.) at the top of the file.
3. **Start Writing**: Add your chapter contents in the `chapters/` directory and use `\include{chapters/your_file}` in `main.tex`.

## 🛠 Compilation

This template relies on `biber` for bibliography management and `minted` for code blocks (which requires the `-shell-escape` flag).

### Using `latexmk` (Recommended)
A customized `.latexmkrc` is included in the directory. You can simply run:
```bash
latexmk main.tex
```
This will automatically handle `pdflatex`, `biber`, and multiple compilation passes, outputting all auxiliary "cruft" files into a hidden `.build_tex/` folder to keep your root directory clean.

### Using VSCode (LaTeX Workshop)
If you use VSCode, a `.vscode/settings.json` is provided. It automatically configures `latexindent` to output its logs into the `.build_tex/` directory so your workspace remains tidy.

## 🎛 Class Options

You can toggle the automatic frontmatter lists directly in `main.tex` by adding options to the `\documentclass`:

```latex
% Example: Disabling the Todo list and List of Tables
\documentclass[notodo, nolot]{IISERKthesis}
```

**Available Toggles:**
- `notodo`: Completely disables the `todonotes` package and removes the Todo List. (Use this for your final submission!)
- `nolof`: Removes the List of Figures.
- `nolot`: Removes the List of Tables.
- `nolol`: Removes the List of Listings.
- `nonom`: Removes the Nomenclature (List of Symbols).

## 📁 Repository Structure

```text
├── IISERKthesis.cls       # The main document class (handles layout and frontmatter)
├── IISERKphysics.sty      # The custom style package (math, minted, theorems, formatting)
├── main.tex               # The root file where you include chapters and set metadata
├── references.bib         # Your bibliography database
├── chapters/              # Folder for your main text (.tex files)
├── appendices/            # Folder for appendices
├── frontmatter/           # Folder for abstracts, acknowledgements, etc.
└── images/                # Folder for figures and logos
```

## 📝 License
Feel free to fork, modify, and use this template for your own thesis!
