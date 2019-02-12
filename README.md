# egamebook.com site

Use `make` to build, serve and deploy. For example:

* `$ make install` to install everything necessary
* `$ make build` to build the site from source
* `$ make serve` to develop the site on `localhost:5000` with a fast edit-refresh cycle
* `$ make deploy` to upload to Firebase
* `$ make clean` to clean up all generated files, useful for a clean build

## Front-end Development

### Serve the site

⚠️ Currently, `make serve` does not watch over changes in SCSS. Run `make build` to compile CSS
(using npm) if any changes to SCSS have been made.

## Before Deploying

### Invalidate cached assets

Before deploying any changes to CSS, images or other media linked in HTML or CSS, update query
string in all requests for such assets. Make sure all requests for a file feature the same query
string, eg.:

```html
<link rel="preload" href="/css/main.min.css?v=2019021201" as="style" />
<!-- … -->
<link rel="stylesheet" href="/css/main.min.css?v=2019021201" />
```

This will force browsers to download the assets even if they had been cached before (may not work
for proxy servers that strip query strings).

### Check links

Always check that links work before deployment. Recommended approach:

#### One-time install 

1. Install [Dart SDK](https://www.dartlang.org/tools/sdk#install), 
   and make sure it's in `$PATH`
2. Install `linkcheck` via `pub global activate linkcheck`

#### Check

1. Start the local server via `make serve`
2. Run `linkcheck` via `linkcheck :5000` (this checks `localhost:5000`)
3. (Optionally) Check external links with `linkcheck :5000 -e`
