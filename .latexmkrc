# --------------------------------------------------------
# .latexmkrc  (place in your project root)
#
# Basic setup for LuaLaTeX + biblatex (via biber) with shell-escape:
#  - PDF mode (directly produce .pdf) using LuaLaTeX
#  - Run lualatex with shell-escape, SyncTeX, and nonstop‐mode
#  - Use biber for biblatex
#  - Rerun LuaLaTeX enough times to resolve cross‐references
#  - Define which extra files to delete on 'latexmk -c'
# --------------------------------------------------------

$aux_dir = '.build_tex';  # Directory for auxiliary files

$times_are_clock = 1;

# For Preview
# $pdf_previewer = 'start "evince" %S';

# 1. Build PDF directly with pdfLaTeX
#    (Equivalent to: latexmk -pdf -pdflatex="pdflatex -shell-escape %O %S")
$pdf_mode = 1;    # 1 => pdf via pdfLaTeX

# 2. How to run pdflatex, including shell-escape:
#    - %O = extra options that latexmk may add
#    - %S = the .tex filename
$pdflatex = 'pdflatex -shell-escape -synctex=1 -interaction=nonstopmode %O %S';

# 3. Tell latexmk to invoke biber when it sees biblatex markers
#    (Instead of the default "bibtex %O %S")
$biber = 'biber %O %S';

# 4. Allow up to 5 LuaLaTeX runs (so that cross‐refs + biber can settle)
#    latexmk will stop early if no further rerun is needed
$max_repeat = 5;

# --------------------------------------------------------
# 5. Cleanup settings: which auxiliary files to remove on `latexmk -c`
# --------------------------------------------------------
# You can adjust this list as needed.  When you run:
#     latexmk -c
# or
#     latexmk -C
# these extensions get wiped out.
push @generated_exts, "bbl", "nlo", "nls";

# Configure latexmk to automatically run makeindex for nomenclature
add_cus_dep('nlo', 'nls', 0, 'makenlo2nls');
sub makenlo2nls {
    my $base = $_[0];
    $base =~ s/.*\///; # Strip directory path to just get basename
    system("cd $aux_dir && makeindex -s nomencl.ist -o $base.nls $base.nlo");
}

# --------------------------------------------------------
# (Optional) 6. To force a full rebuild:
#    latexmk -C    # remove all generated files (including .pdf), then recompile
#    latexmk        # build (runs lualatex → biber → lualatex as needed)
# --------------------------------------------------------

$silent = 1; # hides output from individual compiler passes
