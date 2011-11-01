# Copyright (c) 2011, William J. Bowman
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 		Redistributions of source code must retain the above copyright
# 		notice, this list of conditions and the following disclaimer.
# 		
# 		Redistributions in binary form must reproduce the above copyright
# 		notice, this list of conditions and the following disclaimer in the
# 		documentation and/or other materials provided with the distribution.
# 
# 		Neither the name of the Scheme Site Template nor the names of its
# 		contributors may be used to endorse or promote products derived from
# 		this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
MKDIR=/usr/bin/mkdir
RSYNC=/usr/bin/rsync
RM=/bin/rm
TAR=/usr/bin/tar

TARFLAGS=-J
TARBALL=scheme-site-template.tar.xz
TARFOLDER=scheme-site-template

RSYNCFLAGS=-a
RSYNCFILES=wjb/ examples/
RSYNCEXCLUDES=--exclude=".git" --exclude="*~" --exclude="cv.html"


INSTALLDIR=~/lib/scheme

.PHONY : 
.PHONY : all install tar

all : install

tar : 
	$(MKDIR) $(TARFOLDER)
	$(RSYNC) $(RSYNCFLAGS) $(RSYNCFILES) $(RSYNCEXCLUDES) $(TARFOLDER)
	$(TAR) $(TARFLAGS) -cf $(TARBALL) $(TARFOLDER)
	$(RM) -rf $(TARFOLDER)

install : 
	$(MKDIR) -p $(INSTALLDIR)/wjb
	$(CP) -r wjb $(INSTALLDIR)
	@echo "The library has been install to $(INSTALLDIR)"
	@echo
	@echo "Either specify --libdir $(INSTALLDIR) for your project, or add \
the following"
	@echo "line to your .bashrc:"
	@echo "export CHEZSCHEMELIBDIRS=.:$(INSTALLDIR)"
