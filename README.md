# egamebook.com site

## Requirements

- [Ruby](https://www.ruby-lang.org) v2
- [Bundler](https://bundler.io) v2
- [Jekyll](https://jekyllrb.com) v3
- [Node](https://nodejs.org) v14
- [Firebase tools](https://github.com/firebase/firebase-tools) (optional, can be
  used for manual deployment)

Package versions are a recommended minimum, other versions have not been 
tested. 

## Install

Once all required dependencies are installed on your machine, install the site:

```shell
bundle install && npm install
```

And build it:

```shell
jekyll build && npm run build
```

Now you have the site built in the `_site` directory.

### Bundler and macOS Error

Should you encounter an installation error saying [_Could not create Makefile 
due to some reason_](https://github.com/ffi/ffi/issues/286), make sure you have
[XCode Command Line Tools installed](https://stackoverflow.com/questions/9329243/how-to-install-xcode-command-line-tools).

### Apple M1 errors

One of the dependencies (`redcarpet`) uses `ffi` and fails
on ARM architectures (like Apple's M1 / Silicon) with 
`"missing compatible arch"`. To avoid this, run bundler (and later jekyll)
in compatibility mode:

```shell
arch -arch x86_64 bundle install --path vendor/bundle
```

(The `--path` argument is to avoid installing with `sudo`, another recent
change.)

## Development

For local development run:

```shell
sh serve.sh
```

This runs Jekyll in watch mode, watches front-end assets for changes with 
npm, and serves the site at `http://localhost:3000` (see the script source 
to learn more). Thanks to [BrowserSync](https://www.browsersync.io) running 
in background the site is available across local network.

### Apple M1 version

```shell
sh serve_m1.sh
```

### Video on Site

The homepage has a video screencast of the game in action. To get it, record a
device screen with the correct screen ratio (480 × 984). Then compress the 
video using something like [VideoSmaller](http://www.videosmaller.com) with
width of 480 pixels. (The site has better results than whichever command line
tool and preset I've tried so far.)

## Deployment

The site is automatically deployed to Firebase hosting on push to the `prod`
branch using [GitHub Actions](https://github.com/filiph/egamebook_site/actions).

## Before Deploying

### Invalidate Cached Assets

Before deploying any changes to CSS, images or other media linked in HTML or
CSS, update query  string in all requests for such assets. Make sure all 
requests for a file use the same query string, eg.:

```html
<link rel="preload" href="/css/main.min.css?v=2019021201" as="style" />
<!-- … -->
<link rel="stylesheet" href="/css/main.min.css?v=2019021201" />
```

This will force browsers to download the assets even if they had been cached
before (may not work for proxy servers that strip query strings).

### Check Links

Always check that links work before deployment. Recommended approach:

#### One-time Install 

1. Install [Dart SDK](https://www.dartlang.org/tools/sdk#install), 
   and make sure it's in `$PATH`
2. Install `linkcheck` via `pub global activate linkcheck`

#### Check

1. Start the local server via `make serve`
2. Run `linkcheck` via `linkcheck :5000` (this checks `localhost:5000`)
3. (Optionally) Check external links with `linkcheck :5000 -e`
