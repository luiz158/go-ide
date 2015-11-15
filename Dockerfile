FROM python:2.7.10-wheezy

ENV EDITOR vim
ENV SHELL zsh

RUN apt-get -q update && \
    apt-get install --no-install-recommends -y --force-yes -q \
    ca-certificates \
    zsh \
    tmux \
    curl \
    git \
    vim-nox \
    build-essential \
    cmake \
    python-dev

RUN apt-get clean && \
    rm /var/lib/apt/lists/*_*

RUN gem install tmuxinator

RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    cd ~/.vim/bundle/ && \
    git clone --recursive https://github.com/davidhalter/jedi-vim.git
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
    git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible && \
    git clone https://github.com/Valloric/YouCompleteMe ~/.vim/bundle/YouCompleteMe && \
    git clone https://github.com/garyburd/go-explorer.git ~/.vim/bundle/go-explorer && \
    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

RUN cd ~/.vim/bundle/YouCompleteMe && git submodule update --init --recursive && ./install.sh
RUN curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | /bin/zsh || true

ADD vimrc /root/.vimrc
ADD tmuxinator /root/.tmuxinator
ADD tmux.conf /etc/tmux.conf
ADD zshrc /root/.zshrc

VOLUME ["/python/src"]

CMD ["/usr/local/bin/tmuxinator", "start", "default"]
