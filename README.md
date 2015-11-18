Python IDE in a Container
=========================+

This is an example container that packages zsh, tmux, tmuxinator, vim, and Python-related plugins in a single container.
This example assumes you know how to run Docker.

This is based on https://github.com/saturnism/go-ide-container


Building the Container
----------------------
Nothing special if you already have Docker installed:

    $ git clone https://github.com/saturnism/go-ide-container
    $ cd go-ide-container
    $ docker build -t go-ide-container .

    $ docker run -v /some/path:/go/src -ti saturnism/go-ide

Or, mount a volume from a named container.



