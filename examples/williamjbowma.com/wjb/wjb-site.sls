#!chezscheme
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
;; This file contains the general framework for each page of my site.
;; All pages should import this library and the scheme-site-template.
(library 
  (wjb wjb-site)
  (export    
    defaults
    link)
  (import 
    (wjb scheme-site-template)
    (chezscheme))

;; A list of item to appear on the navigation menu. Each element should
;; be a triple of the href, the link text, and the link target. 
(define nav-menu
  '(("/index/" "Home" . "_self")
    ("/cv/" "Vitae" . "_blank")
    ("/papers/" "Papers" . "_self")
    ("/projects/" "Projects" . "_self")
    ("/blog/" "Blog" . "_self")
    ("/pgp/" "PGP" . "_self")
    ("/links/" "Links" . "_self")))

;; Each menu link is generated through here, expecting the parts of the
;; above triples, to generate a link with a menu-link class.
(define (menu-link page name target)
  `(a (@ (href ,page)
         (class "menu-link")
         (target ,target))
      ,name))

(define (validation)
  `(span (@ (id validation))
         "HTML5 " (a (@ (href "http://validator.w3.org/check?uri=referer"))
                     Validated)
         " | CSS3 " 
         (a (@ (href "http://jigsaw.w3.org/css-validator/validator?uri=http%3A%2F%2Fwww.williamjbowman.com%2Fdefault.css&profile=css3"))
            Validated)))

(define (arvixe)
  `(div (@ (id "arvixe"))
        (a (@ (href "http://www.arvixe.com/linux_web_hosting")
              (target "_blank"))
           "Linux Web Hosting")
        " By Arvixe"))

;; A couple helpers to quickly creating things
(module (link)
  ;; Create a link, given the href and the name
  (define (link href name)
    `(a (@ (href ,href)) ,name)))

(define (defaults)

(favicon-file (lambda () "glider.ico"))

;; For faster, and more static pages, we inline all CSS.
(css-links (lambda () '()))

(css-file (lambda () "resources/default.css"))

(inline-css
  (lambda ()
    (with-input-from-file 
      ((css-file))
      (lambda ()
        (string->symbol (get-string-all (current-input-port)))))))

(meta-author (lambda () "William J. Bowman"))

(main-title (meta-author))

(meta-description 
  (lambda ()
    "Driven researcher with a background in type theory, logical
    relation, compiler design and implmentation, and reversible
    computing."))

(meta-keywords
  (lambda ()
    "William, William J. Bowman, Bowman, Computer Science,
    CompSci, Type Theory, Logical Relations, Function
    Programming, CV, Vitae"))

(body-footer
  (lambda ()
    `((span (@ (id "copyright")) 
            ,(string->symbol "&copy; 2011"))
      ,(validation)
      ,(arvixe))))

(body-header
  (lambda ()
    `((div (@ (class "contact"))
           (span (@ (class "name")) ,((meta-author)))
           (br)
           (span (@ (class "csemail")) wilbowma)))))

(body-nav-menu
  (lambda ()
    `(ul (@ (id menu))
       ,(map (lambda (e) 
               (let* ([page (car e)]
                      [title (cadr e)]
                      [target (cddr e)])
                 `(li ,(menu-link page title target))))
             nav-menu))))))
