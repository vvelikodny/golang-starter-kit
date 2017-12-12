FROM scratch

MAINTAINER Vitaly Velikodny <vvelikodny@gmail.com>

ADD ./app /app

ENTRYPOINT ["/app"]
