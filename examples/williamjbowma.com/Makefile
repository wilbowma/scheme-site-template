SCHEME = scheme
LIBDIRS = .:~/lib/scheme
SFLAGS = --libdirs $(LIBDIRS) --script
#SFLAGS = --script
RM = /bin/rm

LIBS = wjb-site.sls scheme-site-template.sls
SRC = index.ss projects.ss pgp.ss slackbuilds.ss links.ss blog.ss

HTML = $(SRC:.ss=.html) 
DEPS = wilbowma.pub.txt default.css cv.html glider.ico
COPY = $(addsuffix .cp, $(HTML) $(DEPS))

.SUFFIXES :
.SUFFIXES : .ss .html .cp
.PHONY : clean push all

vpath
vpath %.cp .cp/
vpath %.ss src/
vpath %.sls wjb/
vpath % resources/
vpath %.html html/

all : $(HTML)

.ss.html : 
	$(SCHEME) $(SFLAGS) $<

 $(HTML) : $(DEPS) $(LIBS)

# .cp files indicate this file was pushed to the server. By using the
# double colon rule, each file is only pushed if it was rebuild. Upon
# rebuild, it's .cp file is touched
%.cp :: %
	scp -C $< wilbowma@williamjbowman.com:~/public_html/
	touch .cp/$@

push : $(COPY)

clean : 
	(cd html ; $(RM) $(HTML) *~)
