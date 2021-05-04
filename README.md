Demonstration of how to configure VSCode to debug a Go application running in a docker container with a Delve headless debugger running in that container. This demo uses a build `-tags` to show how handle applications that require build tags. This demo also uses an application that has command line arguments to show how delve handles those.

Notes:
- `dlv debug`compiles then debugs your application, it takes in source code
- `dlv exec` debugs and already compiled executable, make sure optimizations are turned off with `-gcflags="-N -l"`

# Demo
- `make build-dev` then `make run` then set a breakpoint somewhere in the main function, then in VSCode run `Attach remote`. You can now step through the code with VSCode. This demo's `dlv debug`
- Same, but with `make build` as the first step. This demo's `dlv exec`
- Same, but with `make build-deploy` as the first step. This demo's `dlv exec` onto a container that doesn't even have source code.
