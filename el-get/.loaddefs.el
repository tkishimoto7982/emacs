;;; .loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "cl-lib" "cl-lib/cl-lib.el" (22239 50312))
;;; Generated autoloads from cl-lib/cl-lib.el
 (let ((d (file-name-directory #$)))
  (when (member d load-path)
    (setq load-path (append (remove d load-path) (list d)))))

;;;***

;;;### (autoloads (el-get el-get-self-checksum el-get-checksum el-get-make-recipes
;;;;;;  el-get-cd el-get-reinstall el-get-remove el-get-self-update
;;;;;;  el-get-update-packages-of-type el-get-update-all el-get-update
;;;;;;  el-get-install el-get-version) "el-get" "el-get/el-get.el"
;;;;;;  (22239 49505))
;;; Generated autoloads from el-get/el-get.el

(autoload 'el-get-version "el-get" "\
Message the current el-get version

\(fn)" t nil)

(autoload 'el-get-install "el-get" "\
Cause the named PACKAGE to be installed after all of its
dependencies (if any).

PACKAGE may be either a string or the corresponding symbol.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update "el-get" "\
Update PACKAGE.

\(fn PACKAGE)" t nil)

(autoload 'el-get-update-all "el-get" "\
Performs update of all installed packages.

\(fn &optional NO-PROMPT)" t nil)

(autoload 'el-get-update-packages-of-type "el-get" "\
Update all installed packages of type TYPE.

\(fn TYPE)" t nil)

(autoload 'el-get-self-update "el-get" "\
Update el-get itself.  The standard recipe takes care of reloading the code.

\(fn)" t nil)

(autoload 'el-get-remove "el-get" "\
Remove any PACKAGE that is know to be installed or required.

\(fn PACKAGE)" t nil)

(autoload 'el-get-reinstall "el-get" "\
Remove PACKAGE and then install it again.

\(fn PACKAGE)" t nil)

(autoload 'el-get-cd "el-get" "\
Open dired in the package directory.

\(fn PACKAGE)" t nil)

(autoload 'el-get-make-recipes "el-get" "\
Loop over `el-get-sources' and write a recipe file for each
entry which is not a symbol and is not already a known recipe.

\(fn &optional DIR)" t nil)

(autoload 'el-get-checksum "el-get" "\
Compute the checksum of the given package, and put it in the kill-ring

\(fn PACKAGE)" t nil)

(autoload 'el-get-self-checksum "el-get" "\
Compute the checksum of the running version of el-get itself.

Also put the checksum in the kill-ring.

\(fn)" t nil)

(autoload 'el-get "el-get" "\
Ensure that packages have been downloaded once and init them as needed.

This will not update the sources by using `apt-get install' or
`git pull', but it will ensure that:

* the packages have been installed
* load-path is set so their elisp files can be found
* Info-directory-list is set so their info files can be found
* Autoloads have been prepared and evaluated for each package
* Any post-installation setup (e.g. `(require 'feature)') happens

When SYNC is nil (the default), all installations run
concurrently, in the background.

When SYNC is 'sync, each package will be installed synchronously,
and any error will stop it all.

Please note that the `el-get-init' part of `el-get' is always
done synchronously. There's `byte-compile' support though, and
the packages you use are welcome to use `autoload' too.

PACKAGES is expected to be a list of packages you want to install
or init.  When PACKAGES is omited (the default), the list of
already installed packages is considered.

\(fn &optional SYNC &rest PACKAGES)" nil nil)

;;;***

;;;### (autoloads (el-get-bundle! el-get-bundle el-get-bundle-el-get)
;;;;;;  "el-get-bundle" "el-get/el-get-bundle.el" (22239 49505))
;;; Generated autoloads from el-get/el-get-bundle.el

(autoload 'el-get-bundle-el-get "el-get-bundle" "\
Not documented

\(fn SRC)" nil nil)

(autoload 'el-get-bundle "el-get-bundle" "\
Install PACKAGE and run initialization FORM.

PACKAGE can be either a simple package name or a package name
with a modifier before the name to specify local recipe source
information:

* `<owner>/' : specifies a Github owner name
* `gist:<id>' : specifies a Gist ID
* `<type>:' : specifies a type of the package source

If `FEATURE in PACKAGE' form is used instead of PACKAGE, then
that FEATURE is `require'd after installing PACKAGE.  You can
also use `el-get-bundle!' macro if FEATURE and PACKAGE are the
same.  If you wish to `require' more than one feature, then use
`:features' property in FORM.

The initialization FORM may start with a property list that
describes a local recipe.  The FORM after the property list is
treated as initialization code, which is actually an `:after'
property of the local recipe.

A copy of the initialization code is stored in a directory
specified by `el-get-bundle-init-directory' and its byte-compiled
version is used if `el-get-bundle-byte-compile' is non-nil.

\(fn PACKAGE &rest FORM)" nil (quote macro))

(autoload 'el-get-bundle! "el-get-bundle" "\
Install PACKAGE and run initialization form.
It is the same as `el-get-bundle' except that PACKAGE is explicitly
required.

\(fn PACKAGE &rest ARGS)" nil (quote macro))

;;;***

;;;### (autoloads (el-get-check-recipe) "el-get-check" "el-get/el-get-check.el"
;;;;;;  (22239 49505))
;;; Generated autoloads from el-get/el-get-check.el

(autoload 'el-get-check-recipe "el-get-check" "\
Check the format of the recipe.
Please run this command before sending a pull request.
Usage: M-x el-get-check-recipe RET

You can run this function from checker script like this:
    test/check-recipe.el PATH/TO/RECIPE.rcp

When used as a lisp function, FILE-OR-BUFFER must be a buffer
object or a file path.

\(fn FILE-OR-BUFFER)" t nil)

;;;***

;;;### (autoloads (el-get-list-packages) "el-get-list-packages" "el-get/el-get-list-packages.el"
;;;;;;  (22239 49505))
;;; Generated autoloads from el-get/el-get-list-packages.el

(autoload 'el-get-list-packages "el-get-list-packages" "\
Display a list of packages.

\(fn)" t nil)

;;;***

;;;### (autoloads (let-alist) "let-alist" "let-alist/let-alist.el"
;;;;;;  (22248 51230))
;;; Generated autoloads from let-alist/let-alist.el

(autoload 'let-alist "let-alist" "\
Let-bind dotted symbols to their cdrs in ALIST and execute BODY.
Dotted symbol is any symbol starting with a `.'.  Only those present
in BODY are let-bound and this search is done at compile time.

For instance, the following code

  (let-alist alist
    (if (and .title .body)
        .body
      .site
      .site.contents))

essentially expands to

  (let ((.title (cdr (assq 'title alist)))
        (.body  (cdr (assq 'body alist)))
        (.site  (cdr (assq 'site alist)))
        (.site.contents (cdr (assq 'contents (cdr (assq 'site alist))))))
    (if (and .title .body)
        .body
      .site
      .site.contents))

If you nest `let-alist' invocations, the inner one can't access
the variables of the outer one. You can, however, access alists
inside the original alist by using dots inside the symbol, as
displayed in the example above.

\(fn ALIST &rest BODY)" nil (quote macro))

;;;***

;;;### (autoloads (list-packages describe-package package-initialize
;;;;;;  package-install-file package-install-from-buffer package-install
;;;;;;  package-enable-at-startup) "package" "package/package.el"
;;;;;;  (22239 50301))
;;; Generated autoloads from package/package.el

(defvar package-enable-at-startup t "\
Whether to activate installed packages when Emacs starts.
If non-nil, packages are activated after reading the init file
and before `after-init-hook'.  Activation is not done if
`user-init-file' is nil (e.g. Emacs was started with \"-q\").

Even if the value is nil, you can type \\[package-initialize] to
activate the package system at any time.")

(custom-autoload 'package-enable-at-startup "package" t)

(autoload 'package-install "package" "\
Install the package named NAME.
Interactively, prompt for the package name.
The package is found on one of the archives in `package-archives'.

\(fn NAME)" t nil)

(autoload 'package-install-from-buffer "package" "\
Install a package from the current buffer.
When called interactively, the current buffer is assumed to be a
single .el file that follows the packaging guidelines; see info
node `(elisp)Packaging'.

When called from Lisp, PKG-INFO is a vector describing the
information, of the type returned by `package-buffer-info'; and
TYPE is the package type (either `single' or `tar').

\(fn PKG-INFO TYPE)" t nil)

(autoload 'package-install-file "package" "\
Install a package from a file.
The file can either be a tar file or an Emacs Lisp file.

\(fn FILE)" t nil)

(autoload 'package-initialize "package" "\
Load Emacs Lisp packages, and activate them.
The variable `package-load-list' controls which packages to load.
If optional arg NO-ACTIVATE is non-nil, don't activate packages.

\(fn &optional NO-ACTIVATE)" t nil)

(autoload 'describe-package "package" "\
Display the full documentation of PACKAGE (a symbol).

\(fn PACKAGE)" t nil)

(autoload 'list-packages "package" "\
Display a list of packages.
Fetches the updated list of packages before displaying.
The list is displayed in a buffer named `*Packages*'.

\(fn)" t nil)

(defalias 'package-list-packages 'list-packages)

;;;***

;;;### (autoloads nil nil ("cl-lib/cl-lib-autoloads.el" "cl-lib/cl-lib-pkg.el"
;;;;;;  "el-get/el-get-autoloading.el" "el-get/el-get-build.el" "el-get/el-get-byte-compile.el"
;;;;;;  "el-get/el-get-core.el" "el-get/el-get-custom.el" "el-get/el-get-dependencies.el"
;;;;;;  "el-get/el-get-install.el" "el-get/el-get-methods.el" "el-get/el-get-notify.el"
;;;;;;  "el-get/el-get-recipes.el" "el-get/el-get-status.el" "let-alist/let-alist-autoloads.el"
;;;;;;  "let-alist/let-alist-pkg.el") (22248 51230 914749))

;;;***

(provide '.loaddefs)
;; Local Variables:
;; version-control: never
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; .loaddefs.el ends here
