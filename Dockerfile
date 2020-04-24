FROM debian:buster
LABEL maintainer="Yiching TSENG<yictseng@student.le-101.fr>"
WORKDIR /ft_server
COPY srcs /ft_server
RUN apt-get update && apt-get upgrade -y
EXPOSE 80 443	
ENTRYPOINT ["sh", "server.sh"]
