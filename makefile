MARKDOWN_TOPLEVEL := $(wildcard *.markdown)
MARKDOWN_SUBDIRS := $(wildcard **/*.markdown)

.SECONDARY: .full_build.intermediate

build: .full_build.intermediate
	@echo "=== Site built ==="

deploy: .full_build.intermediate
	firebase deploy

.full_build.intermediate: $(MARKDOWN_TOPLEVEL) $(MARKDOWN_SUBDIRS)
	npm run build:css
	jekyll build
	touch .full_build.intermediate

serve:
	rm -f .full_build.intermediate  # serving builds a local site
	./serve.sh

install:
	gem install bundler
	bundle install
	npm install -g firebase-tools superstatic
	npm install

clean:
	rm -fr .sass-cache/
	rm -fr _site/
	rm -f .full_build.intermediate
