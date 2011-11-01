#!chezscheme
(library 
  (wjb scheme-site-template)
  (export 
    doctype
    html-attrs
    html-section
    main-title
    title-delim
    subtitle
    page-title
    meta-description
    meta-author
    meta-content-type
    meta-keywords    
    meta-section
    favicon-file 
    css-file 
    favicon-links
    css-links
    links-section
    inline-css
    style-section
    head-section
    body-header
    body-content
    body-nav-menu
    body-footer
    body-section
    sxml-compiler
    compile-to-string
    compile-to-file)
  (import 
    (only (srfi :13) string-suffix-ci?)
    (only (srfi :1) every) 
    (only (oleg sxml-to-html) sxml->html)
    (chezscheme))

;;TODO: Some parameters are wrapped in thunks, while some are not. Need
;;to handle these differently in their filters. I've hacked a quick
;;chagne together, but it's not the best solution.
(define param-filter 
  (case-lambda 
    [(pred?) (lambda (x) 
               (if (pred? x)
                 x
                 (errorf 'param-filter 
                         "Invalid value for parameter: ~s" x)))]
    [(pred? str) (lambda (x)
                   (if (pred? x)
                     x
                     (errorf 'param-filter str x)))]))

(define wrapped-param-filter
  (case-lambda
    [(pred?)
     (lambda (x)
       (lambda () ((param-filter pred?) (x)) ))]
    [(pred? str)
     (lambda (x)
       (lambda () ((param-filter pred? str) (x)) ))]))

(define (param-err name msg)
  (format "Invalid value for parameter ~s. ~a" name msg))

(define (sxml-filter name)
  (wrapped-param-filter 
    (lambda (x) (or (pair? x) (null? x)))
    (param-err name "~s is not a pair")))

(define (proc-filter name)
  (param-filter
    procedure?
    (param-err name "~s is not a procedure")))

(define (string-filter name)
  (wrapped-param-filter
    string?
    (param-err name "~s is not a string")))

(define (symbol-filter name)
  (wrapped-param-filter
    symbol?
    (param-err name "~s is not a symbol")))

;; Check that the tree starts with a tag. Tree should be an SXML tree,
;; and tag should be a symbol.
(define (tag-eq? tag)
  (lambda (tree)
    (and (pair? tree) (eq? (car tree) tag))))

(define (gtag-filter f tag name)
  (f
    (tag-eq? tag)
    (param-err name "~s is not the correct tag type.")))

(define (wtag-filter tag name)
  (gtag-filter wrapped-param-filter tag name))

(define (tag-filter tag name)
  (gtag-filter param-filter tag name))

(define (every-tag-filter tag name)
  (lambda (ls)
    (if (every (lambda (x)
                 (and (tag-filter tag name) #t)) (ls))
      ls
      #f)))

;; A list containing the DOCTYPE used for this html page. The DOCTYPE
;; should be a symbol. The default value is the DOCTYPE for HTML 5.
;; The default value has an empty string used to help pretty up the
;; output.
(define doctype
  (make-parameter 
    (lambda () '("" |<!DOCTYPE html>|)) 
    (sxml-filter 'doctype)))

;; A list of attributes to add the HTML tag. The default value is empty,
;; as HTML 5 doesn't use anything interesting.
(define html-attrs 
  (make-parameter 
    (lambda () '()) 
    (sxml-filter 'html-attrs)))

;; The first part of a Main Title <delim> Subtitle kind of title. It
;; should be a string. The default is rather generic and should be
;; replaced.
(define main-title 
  (make-parameter 
    (lambda () "My Homepage") 
    (string-filter 'main-title)))

;; The second part of a Main Title <delim> Subtitle kind of title. It
;; should be a string. The default is rather generic and should be
;; replaced.
(define subtitle 
  (make-parameter 
    (lambda () "Some page") 
    (string-filter 'subtitle)))

;; The delimiter part of Main Title <delim> Subtitle kind of title. It
;; should be a string. The default is " | ".
(define title-delim 
  (make-parameter 
    (lambda () " | ") 
    (string-filter 'title-delim)))

;; The page title. Many websites take on a pattern of main-title <delim>
;; sub-title, so that's the default.
(define page-title
  (make-parameter
    (lambda () 
      `(title ,(string-append ((main-title)) ((title-delim))
                              ((subtitle)))))
    (wtag-filter 'title 'page-title)))

;; The content-type meta information. Defaults to UTF-8 text/html.
(define meta-content-type
  (make-parameter 
    (lambda () "text/html; charset=UTF-8") 
    (string-filter 'meta-content-type)))

;; The author of the page. Defaults to empty.
(define meta-author 
  (make-parameter 
    (lambda () "") 
    (string-filter 'meta-author)))

;; The meta description of the page. Defaults to empty.
(define meta-description 
  (make-parameter 
    (lambda () "") 
    (string-filter 'meta-description)))

;; The meta keywords of the page. Defaults to empty.
(define meta-keywords 
  (make-parameter 
    (lambda () "") 
    (string-filter 'meta-keywords)))

;; The meta section of the html page. Default fills in the Content-Type,
;; author, description, and keywords.
(define meta-section
  (make-parameter
    (lambda ()
      `((meta (@ (http-equiv "Content-Type")  
                 (content ,((meta-content-type)))))
        (meta (@ (name author) (content ,((meta-author)))))
        ;(meta (@ (name language) (content "en/US")))
        (meta (@ (name description) (content ,((meta-description)))))
        (meta (@ (name keywords) (content ,((meta-keywords)))))))
    (every-tag-filter 'meta 'meta-section)))

;; A curried version of string-suffix-ci?, for checking that a parameter
;; ends in a particular extension.
(define (extension-eq? ext)
  (lambda (str)
    (string-suffix-ci? ext str)))

(define (extension-filter ext name)
  (wrapped-param-filter
    (extension-eq? ext)
    (param-err name "~a does not have the correct extension")))

;; The favicon file. Defaults to "favicon.ico".
(define favicon-file 
  (make-parameter 
    (lambda () "favicon.ico") 
    (extension-filter ".ico" 'favicon-file)))

;; The default css file. Defaults to "default.css".
;; TOOD: Make a list of css files.
;; TODO: Add error messages to parameter filters.
(define css-file 
  (make-parameter 
    (lambda () "default.css")
    (extension-filter ".css" 'css-file)))

;; The link tags for favicons. Defaults to a shortcut icon and icon link
;; to the favicon file. should always be a list of link tags.
(define favicon-links
  (make-parameter
    (lambda ()
      `((link (@ (rel "shortcut icon") 
                 (type "image/ico")
                 (href ,((favicon-file)))))
        (link (@ (rel "icon") 
                 (type "image/ico")
               (href ,((favicon-file)))))))
    (every-tag-filter 'link 'favicon-links)))

;; The link tags for css files. Defaults to loading the css file. Should
;; be a list of link tags.
;; TODO: With multiple css files, generate this list.
(define css-links
  (make-parameter
    (lambda ()
      `((link (@ (rel "stylesheet") 
                 (type "text/css")
                 (href ,((css-file)))))))
    (every-tag-filter 'link 'css-links)))

;; TODO: Add javascript links.
;; 

;; Create a links section. Defaults to loading the favicon and css
;; files. Shoud be a list of link tags.
(define links-section
  (make-parameter
    (lambda ()
      `(,((favicon-links))
         ,((css-links))))
    (every-tag-filter 'link 'links-section)))

;; The inline css. Because SXML likes to escape things in
;; string, this should be specified as a symbol. Use '| | block symbol
;; escapes. Defaults to empty.
(define inline-css 
  (make-parameter 
    (lambda () '||) 
    (symbol-filter 'inline-css)))

;; The inline css style section. Defaults to the inline-css
(define style-section
  (make-parameter 
    (lambda () `(style ,((inline-css))))
    (wtag-filter 'style 'style-section)))

;; The head subtree. By default, contains the page-title, meta-section,
;; links-section, and style-section. Seems silly to change this too.
;; Regardless, the start of the tree should be a head tag.
(define head-section
  (make-parameter
    (lambda ()
      `(head ,((page-title))
             ,((meta-section))
             ,((links-section))
             ,((style-section))))
    (wtag-filter 'head 'head-section)))

;; The header portion of the body. Defaults to an h1 of the subtitle.
(define body-header 
  (make-parameter 
    (lambda () '(h1 ,((subtitle)))) 
    (sxml-filter 'body-header)))

;; The content portion of the body. This should contain the content for
;; the page. Defaults to a welcome message.
(define body-content 
  (make-parameter 
    (lambda () '(p "Welcome to my site!")) 
    (sxml-filter 'body-content)))

;; The default navigation menu. This should contain the nav menu for
;; your site. The default is just a home link to index.html
(define body-nav-menu
  (make-parameter
    (lambda () '((a (@ (href "/index.html")) Home)))
    (sxml-filter 'body-nav-menu)))

;; The foot of the page. Defaults to a copyright notice.
(define body-footer
  (make-parameter 
    (lambda () '(|Copyright &copy;|)) 
    (sxml-filter 'body-footer)))

;; The body section of the page. Defaults to 4 sections, with ids:
;; header, nav-menu, content, footer. The sections are filled with the
;; respective parameters.
(define body-section
  (make-parameter
    (lambda () 
      `(body
         (section 
           (@ (id top))
           (section (@ (id header))
                    ,((body-header)))
           (section (@ (id nav-menu))
                    ,((body-nav-menu))) 
           (section (@ (id content))
                    ,((body-content)))
           (section (@ (id footer))
                    ,((body-footer))))))
    (wtag-filter 'body 'body-section)))

;; The default start of the HTML tree. The default build an html page,
;; starting with the DOCTYPE, followed by the HTML tag, containing the
;; head-section, and the body-section. It might be hard to justify
;; changing this.
(define html-section
  (make-parameter 
    (lambda ()
      `(,((doctype))
         (html ,((html-attrs))
               ,((head-section))
               ,((body-section)))))
    (sxml-filter 'html-section)))

;; A procedure that takes an SXML expression and write the compiled
;; output to the current output port. The procedure should take a single
;; arguement: the SXML expression. Defaults to Oleg's sxml->html.
(define sxml-compiler 
  (make-parameter 
    sxml->html 
    (proc-filter 'sxml-compiler)))

;; Returns the compiled SXML expression as a string.
(define (compile-to-string) 
  (with-output-to-string
    (lambda () ((sxml-compiler) ((html-section))))))

;; Compiles the SXML expression and outputs the compiled expression to
;; the given file. Deletes the file if it exists.
(define (compile-to-file filename)
  (when (file-exists? filename)
    (delete-file filename))
  (with-output-to-file 
    filename
    (lambda () ((sxml-compiler) ((html-section)))))))
