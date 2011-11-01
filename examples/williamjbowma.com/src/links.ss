#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))
(defaults)
(subtitle (lambda () "Links"))
(body-content
  (lambda ()
    `("Awesome things, helpful things, silly things, things from
      across the interwebs are listed here."
      (br)(br)
      (ul
        (li (a (@ (href "http://www.w3schools.com/")
                  (target "_blank"))
               "W3Schools")
            ": Just about every tutorial for internet development
        one could want.")
      (li (a (@ (href "http://www.learnyouahaskell.com/")
                (target "_blank"))
             "Learn you a Haskell")
          ": A fantastic Haskell tutorial.")
      (li (a (@ (href "http://www.scheme.com/csug8/")
                (target "_blank"))
             "Chez Scheme User Guide 8")
          ": An important resource for Chez Schemers")))))

(compile-to-file "html/links.html")
