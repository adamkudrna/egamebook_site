MARKDOWN_TOPLEVEL := $(wildcard *.markdown)
MARKDOWN_SUBDIRS := $(wildcard **/*.markdown)

.SECONDARY: .full_build.intermediate

build: .full_build.intermediate
	@tput setaf 2; echo "Site built"; tput sgr 0

deploy: .full_build.intermediate
	firebase deploy

.full_build.intermediate: $(MARKDOWN_TOPLEVEL) $(MARKDOWN_SUBDIRS)
	jekyll build
	npm run build
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
	rm -fr _css/
	rm -fr _site/
	rm -fr node_modules/
	rm -f .full_build.intermediate
