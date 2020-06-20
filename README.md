# healpix-webvix

Based on the [Getting Started with
Parcel](https://github.com/purescript/spago#get-started-from-scratch-with-parcel-frontend-projects)
guide from the spago documentation.

## Development Guide

1. Needs npm, purescript and spago.
1. Enter a live dev environment with:
   ```
   npm run dev
   ```
   This will serve a web site from the local machine.
1. Build the PureScript in a different window with:
   ```
   spago build --watch
   ```
1. Format the source code with:
   ```
   npm run format
   ```
   
## Production Build

For a production build:

```
npm run build
```
