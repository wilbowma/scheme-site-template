#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))

(defaults)

(subtitle (lambda () "Home"))

(body-content
  (lambda ()
     `((p "Welcome to my homepage. I'm gradually moving over from my
       previous site, and teaching myself web design, so please
       excuse the construction.")

      (p "I am a graduate student at Indiana University, studying
        Computer Science (specifically, programming languages). I'm
        interested in efficiency, be it through automation, faster
        development, proven correctness, or pure clock cycles. I'm
        also into video games, gardening, and cats.")

      (p "This website is completely static, and generated using "
        ,(link "http://www.scheme.com/" "Chez Scheme") " and "
        ,(link "http://okmij.org/ftp/Scheme/SXML.html" "sxml") 
        " (specifically the version for Chez Scheme available through "
        ,(link "http://www.sacrideo.us/" "http://www.sacrideo.us/")".) 
        Many thanks to the respective developers.")
        (div (@ (class push))))))

(compile-to-file "html/index.html")
