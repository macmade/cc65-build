#-------------------------------------------------------------------------------
# The MIT License (MIT)
# 
# Copyright (c) 2014 Jean-David Gadina - www-xs-labs.com
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#-------------------------------------------------------------------------------

DIR_BUILD   := $(realpath ./)/build/
DIR_TMP     := $(realpath ./)/temp/
DIR_TMP_GIT := $(DIR_TMP)cc65/

CC65_GIT_REPOS  := https://github.com/cc65/cc65
CC65_GIT_BRANCH := master

.PHONY: clone update build

all: clone update build
	
	@:

clean:
	
	@rm -rf $(DIR_TMP)*
	
clone:
	
	@if [ ! -d $(DIR_TMP_GIT) ]; then git clone --recursive $(CC65_GIT_REPOS) $(DIR_TMP_GIT); fi
	
update:
	
	@cd $(DIR_TMP_GIT) && git reset HEAD .
	@cd $(DIR_TMP_GIT) && git checkout -- .
	@cd $(DIR_TMP_GIT) && git clean -fd
	@cd $(DIR_TMP_GIT) && git checkout $(CC65_GIT_BRANCH)
	@cd $(DIR_TMP_GIT) && git pull
	
build:
	
	@cd $(DIR_TMP_GIT) && make
	@cp $(DIR_TMP_GIT)bin/* $(DIR_BUILD)
