# fetch-schedule.el

Emacs-lisp script to fetch exported calendar from URL and import into diary/calendar of emacs.
Exported calendar must be in .ics format.

Neat tool if you have a schedule with a lot of changes since you can update your calendar from within emacs with a single click.

## Usage

*Download the source and add it to the load-path*
```emacs-lisp
(load-file "~/.emacs.d/fetch_schedule.el")
```
*Require it and set parameters*

``` emacs-lisp

;; fetch KTH schedule
(require 'fetch-schedule)

;;URL to exported calendar
(setq diary-remote-calendar "https://www.kth.se/social/user/192266/icalendar/1e3697b6ecf223b57d5q41f56a0ad2090c2btf0w")

;;file to save the importeddiary
(setq diary-remote-calendar-local-replica "~/Dropbox/org/kth_diary")

```
Note that for easier integration of schedule updates you should keep the imported diary and your local diary-notes separate and use the fancy-display import as follows inside your local diary-notes:

``` shell

Jun 10, 2017 Tvätt 16-19
Jun 16, 2017 Resa till Prag
...
...
#include "~/Dropbox/org/kth_diary"
...
...

```

Now whenever you want to update your calendar simply type `M-x fetch-schedule`.

## Author & Maintainer

Kim Hammar <kimham@kth.se>

## Copyright and license

[LICENSE](LICENSE.md)

MIT

(C) 2017, Kim Hammar
