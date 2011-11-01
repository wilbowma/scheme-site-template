#!/usr/bin/scheme --script
;; Copyright (c) 2011, William J. Bowman
;; All rights reserved.
;; 
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are
;; met:
;; 
;; 		Redistributions of source code must retain the above copyright
;; 		notice, this list of conditions and the following disclaimer.
;; 		
;; 		Redistributions in binary form must reproduce the above copyright
;; 		notice, this list of conditions and the following disclaimer in the
;; 		documentation and/or other materials provided with the distribution.
;; 
;; 		Neither the name of the Scheme Site Template nor the names of its
;; 		contributors may be used to endorse or promote products derived from
;; 		this software without specific prior written permission.
;; 
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
;; IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
;; TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
;; PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;; HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;; SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;; TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
;; PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
;; LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
;; NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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
