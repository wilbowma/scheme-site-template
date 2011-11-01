#!/usr/bin/scheme --script

(import (wjb scheme-site-template))

;; After importing, all the default parameters are available.
;;
;; We want to overwrite the subtitle of this page
(subtitle (lambda () "Home"))

;; And the body-content.
;; See the library for details on each parameter.
(body-content
  (lambda ()
     `(p "Hello, this is my website written in Scheme!")))

;; Finally, we compile this page and output to the file index.html
(compile-to-file "index.html")
