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
        Many thanks to the respective developers."))))

(compile-to-file "html/index.html")
