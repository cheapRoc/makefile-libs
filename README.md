# makefile-libs

Simple Makefile utilities and libraries that format version numbers, build
Docker images, etc.

The libraries in this repo provide both simple automated builds for projects
utilizing a `Dockerfile` as well as version number handling.

I've included how I like to namespace and build my container images in the form
of transparent and codified build policy. This includes version tagging and
private publishing commands as well.

I've also included simple version number formatting support with optional
environment variable and version stash files overrides that can be dropped by
build automation. Sometimes you want to track and iterate your `major` and
`minor` version numbers from your repo while leaving your automated build
processing to continually iterate patch versions and commit hash snapshots.

## Usage

Reference the `Makefile` for default usage and library includes. Otherwise, this
project can be copied or symlinked out into another project (*ahem* with a
Dockerfile).

Stick `@echo` in front of docker commands to see the output before you
execute. Might be nice to throw a `DEBUG` switch in there for viewing commands
without needing to change the files yourself.
