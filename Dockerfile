FROM alpine:3.7

ENV PYTHON_VERSION="2.7.14"

WORKDIR /root
ADD https://github.com/pyenv/pyenv/archive/v1.2.1.tar.gz /tmp/
RUN mkdir -vp .pyenv \
  && tar xzf /tmp/v1.2.1.tar.gz --strip-components=1 -C .pyenv \
  && rm -v /tmp/*.tar.gz
RUN apk add --no-cache --virtual basics \
    bash \
    openssl-dev \
  && apk add --no-cache --virtual python-build-deps \
    build-base \
    bzip2-dev \
    expat-dev \
    gdbm-dev \
    libbz2 \
    libc6-compat \
    libffi-dev \
    linux-headers \
    ncurses-dev \
    patch \
    paxmark \
    readline-dev \
    sqlite-dev \
    tcl-dev \
    xz-dev \
    zlib-dev \
  && $HOME/.pyenv/bin/pyenv install $PYTHON_VERSION \
  && $HOME/.pyenv/bin/pyenv global $PYTHON_VERSION \
  && apk del python-build-deps
RUN printf "%s\n" \
  "export PYENV_ROOT=\"$HOME/.pyenv\"" \
  "export PATH=\"$HOME/.pyenv/bin:$PATH\"" \
  "eval \"\$(pyenv init -)\"" >> .bashrc

ENTRYPOINT ["bash", "-l"]
