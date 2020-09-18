;;; slidify-pages.el --- Slide-style page navigation -*- lexical-binding: t -*-

;; Copyright © 2015 Eli Naeher <eli@naeher.name>

;; Author: Eli Naeher <eli@naeher.name>
;; URL: https://github.com/enaeher/slidify-pages

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This dirt-simple minor mide provides slide-style page
;; navigation. It is intended to facilitate using Emacs for
;; presentations that involve code samples and interactive code use,
;; while being sufficiently unobtrusive to co-exist peacefully with
;; your preferred code editing modes.
;;
;;; Code:

(defun slidify-pages--update-mode-line ()
  "Sets the mode line lighter to indicate the current page and
the total number of pages. Called after every page change, and
when the mode is first enabled."
  (setq slidify-pages-mode-line
	(concat " Page " (number-to-string (slidify-pages-current-page-number))
		" of " (number-to-string (slidify-pages-total-pages)))))

;;;###autoload
(defun slidify-pages-previous-page ()
  "Navigate to the previous page."
  (interactive)
  (goto-char (point-min))
  (widen)
  (backward-page)
  (backward-page)
  (narrow-to-page)
  (slidify-pages--update-mode-line))

;;;###autoload
(defun slidify-pages-next-page ()
  "Navigate to the next page."
  (interactive)
  (forward-page)
  (narrow-to-page)
  (slidify-pages--update-mode-line))

(defun slidify-pages-current-page-number ()
  "Returns the 1-indexed number of the page at point."
  (save-restriction
    (widen)
    (1+ (how-many page-delimiter (point-min) (point)))))

(defun slidify-pages-total-pages ()
  "Returns the total number of pages in the buffer."
  (save-restriction
    (widen)
    (1+ (how-many page-delimiter (point-min)))))

(defun slidify-pages--enable ()
  (narrow-to-page)
  (read-only-mode 1))

(defun slidify-pages--disable ()
  (widen)
  (read-only-mode 0))

(defvar slidify-pages-mode-map (make-sparse-keymap) "Slidify-Pages keymap.")

(define-key slidify-pages-mode-map (kbd "<left>") 'slidify-pages-previous-page)
(define-key slidify-pages-mode-map (kbd "<right>") 'slidify-pages-next-page)

;;;###autoload
(define-minor-mode slidify-pages-mode
    "A minor mode allowing slide-style navigation between pages,
with automatic narrowing of the buffer to the current page.

Pages are delimited by the built-in Emacs `page-delimiter'
variable. While in slidify-pages-mode, the buffer is made read-only."
  :init-value nil
  :lighter slidify-pages-mode-line
  :keymap slidify-pages-mode-map
  (if slidify-pages-mode
      (slidify-pages--enable)
      (slidify-pages--disable))
  (slidify-pages--update-mode-line))

(provide 'slidify-pages)

;; end of slidify-pages.el
