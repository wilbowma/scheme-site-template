#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))

(defaults)

(subtitle (lambda () "Projects"))

(body-content
  (lambda ()
    `("A listing of various projects, past and present."
      (br)(br)
      (ul
        (li ,(link "/slackbuilds/" "SlackBuilds"))))))

(compile-to-file "html/projects.html")
