#!/usr/bin/scheme --script

(import (wjb scheme-site-template)
        (wjb wjb-site))

(defaults)

(define public-key
  `(span 
     (@ (class code))
     "-----BEGIN PGP PUBLIC KEY BLOCK-----" (br)
     "Version: GnuPG v1.4.11 (GNU/Linux)"
     (br)(br)
     "mQMuBE3fLhwRCADd/aBW1cZtGI0X9dejuy6dnBL+9Hg6Co99uyeI9EEPMVfEdmCw"(br)
     "yE3Cp5k2Enod3owc7FxQHYAXhxwtiLK+xxE0fGiiyZH8Ad2p2auPmGMwOw5IIX6z"(br)
     "xIdMktwyzDhp08qFNgBTxzACTo+OVi5+SHHpMNmpLFFdUhi01mcVFHqi8UEkcIFa"(br)
     "0EKPp9wCGg2NgN9eRPJdz4fSw7yeD3tufbW+iFPuhe9/+ofVYJ3RWgVbrhdT9q5o"(br)
     "iVoWX9d7aVhKqA7J6e0HDFPWFK/JHQh+e/evyvt3p7AxXhk14Df+WB0dWY3t2juD"(br)
     "7RPM65eBcAx1l4VGn5eGzJIPiXDd7JBSkSsbAQDOtAk9NsZ9D3mlxAhi+3//Lqbh"(br)
     "BxOCRiZhMoO9Sloogwf6AupbRdO1bdQvF3Z/3TqMvcL5XEXHsceU5edcni9gTqmK"(br)
     "+/rv1gX3vYQ2L3MnBSdDZysDk7JmsnQpm9rA6oKWirrxhmBoW7Un7LCMmLd+8j1F"(br)
     "1lXlERpNXktKNCHoaV+ZrlfO9vAHTFXlnE81n8sp2ueO83e9jPdIhV6wxi3emB/D"(br)
     "OUnREjbf+e+UyBQxdiXloMF08d9iK5KJ7rqyRsdg4j8xMqZqfb0diaEqut+vM05T"(br)
     "1TvoH5kNg+Kp0cO2teJUHK2rGBwiqJtgjrTGSn73g2nJ8Y0ijYyjBXvrOmK40hVp"(br)
     "162TE653ig2HfhvZlSlkzHPtBwIxbAUA/foexvvSxQf/VtiqgyiJ4tzbFqdyK+go"(br)
     "lxf7BSaQs5oNbKse1+WQ9ACelb0b0xY5EJA48RUrjg97FK5GjfsD7Rsh/XIYLmPq"(br)
     "wn+8SMQW1G2UD8sW90VXAVM+T1boMr8L3ISr5Vo7Bu7T+HkJ4+mvywVKR7GUFBjp"(br)
     "VIGgKVGlXE9s6JFDkHzDbQ2Z8drB8LZGPmx/bbAxGtFjbSUC8pGsH4b4jljc+K8y"(br)
     "jbHWKi+R+nFPLXF1Umw0MEfU0ZxhxJeLjsv/TfDXqh3S6upkugwjvIXxCwzl8iHd"(br)
     "UzfUwTVC4eFHLhQEMAn5vwtFLnmFErz/mBMQ7HHCe4R2D7TAJ/o5DXz0kvKMHZdJ"(br)
     "HbQnV2lsbGlhbSBKIEJvd21hbiA8d2lsYm93bWFAaW5kaWFuYS5lZHU+iHoEExEI"(br)
     "ACIFAk3fLhwCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEFivTRzmFj1g"(br)
     "JcgBAJDQJve+WpkP35LUMyyGv+f2dp6vBfNOboKJLhzTY6OjAP9BpNSWNJETVOmH"(br)
     "CudETel8uxDlIoW0Dw9o9PVoPD8Gh7kCDQRN3y4cEAgAh8CCT+OtbY/pW0GqKdvS"(br)
     "iIj7a9nKTmbJd3im0uXEUXkBG3mVCxBNA6LRqdmXAhsd8wy4eQQ5biEENQnvmNCq"(br)
     "GOwQVfm2okmerxxyWzVtnebvYOUkjR6/s25Zcn9LY+yzIWuLsjJmL1BnquFvyaqk"(br)
     "PO8am9EJetXdQDtUhK4zeaKk0ZBhpJUHXki2J780zqPOUCS/N4NxGb+KxxebL6QG"(br)
     "ljrjhXfbPWRcDSEjoxmyi235Dur40L+xlOn5Grv4DVDf8K+YDRTvaK3GYUZm7ZMo"(br)
     "HZmTIWdaeok7w72Gzd4/bVTCURve4vNU391aIssy72LWr3xUL2PEtl+KuBiNvaR4"(br)
     "IwADBgf8CfZ6rjVvnRGFjzRlaIgXnmn+s/UvHIg5o4o67Nt5fVRkAVuDUrdV2r2g"(br)
     "s9i9ag8pTL3/G+GZyMB+iwnDmHrIBCgQBqHLeDR/egJpHoCUAOpxPRXqF3WSkAeg"(br)
     "NLB+DgmAVTFLNwoREzL+VYRQNT+vB2UHic1HUCKeZ784pkIkDcz5EAXvD2h6CV1n"(br)
     "wxgFOxRP3s4KkiZPcN8c79++HoidJim6y0h2vayoYZE5mpENeJrpp8s1JP7hCwc1"(br)
     "VEgogF6K7qANu5bFNYdZQgJAkCc6a5hJlKBuj8oTdg7j3t07tRDKpfqiuCpR+dbe"(br)
     "hVzf5n1+wA7i1ls9vtFgX2uFcPfeaIhhBBgRCAAJBQJN3y4cAhsMAAoJEFivTRzm"(br)
     "Fj1gy8MA/3kAqGRyk9gp2wLEbLS623fRYr49oNKgt8uO27fUoQu8APkBhKWnIiLx"(br)
     "y9kqmfjfrtDE3i9zbaN/4OQGATCcdEz1wg=="(br)
     "=oHWZ"(br)
     "-----END PGP PUBLIC KEY BLOCK-----"(br)))

(define finger-print
  `(span (@ (class code))
         "F8F3 4F7E F3DD D758 C4A4  3027 58AF 4D1C E616 3D60"))

(subtitle (lambda () "PGP"))

(body-content
  (lambda ()
    `("My PGP public key and finger print are available here, for
      secure communication, if you're into that kind of thing. The
      public key is also available via key serves."
      (br)(br)
      "Fingerprint: " ,finger-print (br)
      (a (@ (href "/wilbowma.pub.txt")) "Public Key:")
      (br)(br)
      ,public-key)))

(compile-to-file "html/pgp.html")
