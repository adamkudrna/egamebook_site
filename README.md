# egamebook.com site

Use `make` to build, serve and deploy. For example:

* `$ make install` to install everything necessary
* `$ make build` to build the site from source
* `$ make serve` to develop the site on `localhost:5000` with a fast edit-refresh cycle
* `$ make deploy` to upload to Firebase

## Front-end Development

Currently, `make serve` does not watch over changes in SCSS so `make build` needs to be run to
compile CSS (handled by npm) and inject it into Liquid templates (handled by Jekyll) if any changes
to SCSS have been made.
