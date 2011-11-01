#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))

(defaults)

(define (sb link name)
  `(a (@ (href ,(string-append "http://slackbuilds.org/repository/13.37/"
                               link)))
      ,name))

(subtitle (lambda () "SlackBuilds"))
(body-content
  (lambda ()
    `("I run Slackware current, and find myself maintaining more and
        more SlackBuilds. This is a list of builds I maintain. If ever
        you should need one updated, let me know, and I'll try to get
        around to it. If you want to submit a patch, I'll get it updated
        more quickly :."
        (br)
        (ul
          (li ,(sb "academic/coq" "Coq"))
          (li ,(sb "development/camlp5" "Camlp5"))
          (li "HAVP (pending)")))))

(compile-to-file "html/slackbuilds.html")
