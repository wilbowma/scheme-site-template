#!chezscheme
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
    ("/blog/" "Blog" . "_self")
    ("/projects/" "Projects" . "_self")
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
            ,(string->symbol "Copyright &copy; 2011"))
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
