# slidify-pages

This dirt-simple minor mode provides slide-style page navigation. It
is intended to facilitate using Emacs for presentations that involve
code samples and interactive code use, while being sufficiently
unobtrusive to co-exist peacefully with your preferred code editing
modes--so that you can, for example, send code to a REPL, enjoy
`eldoc-mode` functionality, jump to source, etc.

Unlike other Emacs-based presentation tools, `slidify-pages` doesn't
require that you organize your presentation source to fit a specific
mode, like `org-mode` or `outline-mode`, nor does it require a
presentation definition separate from the presentation
source.

Instead, any file, in any major mode, can be used as a presentation
source; you simply separate "slides," or pages, using text which
matches the regular expression defined in the
[`page-delimiter`](http://www.gnu.org/software/emacs/manual/html_node/emacs/Pages.html)
variable. (This variable's default value, `^\f`, matches the
form-feed, or `^L`, character when it occurs at the beginning of a
line. As a delimiter this character has the advantage of being treated
as whitespace by most programming languages. It is easily entered in
Emacs with <kbd>C-q C-l</kbd>.)

When `slidify-pages` is enabled using the `slidify-pages-mode`
command, the buffer will be narrowed to display only the current page,
and the buffer will be made read-only. Navigation between pages is as
described below, and the mode line will indicate the page and total
number of pages.

## Navigation

Default keybinding   | Command                     | Description
---------------------|-----------------------------|-------------------------------
<kbd>\<left\></kbd>  | slidify-pages-previous-page | Navigate to the previous page.
<kbd>\<right\></kbd> | slidify-pages-next-page     | Navigate to the next page.
