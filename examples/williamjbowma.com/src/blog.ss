#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))

(defaults)
(subtitle (lambda () "Blog"))

(body-content
  (lambda ()
    `("Eventually, I'll put my blog here. For now, you can view it at "
      (a (@ (href "http://williambowman.it.cx/")
            (target "_blank"))
         "my old site."))))

(compile-to-file "html/blog.html")
