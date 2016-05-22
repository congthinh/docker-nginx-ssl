## Mobivi NginX SSL
## May 2016

FROM nginx:1.9.15
MAINTAINER Thinh Huynh "thinhhc@gmail.com"

## Add Ubuntu Xenial to sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main universe" >> /etc/apt/sources.list

# Let the container know that there is no tty 
ENV DEBIAN_FRONTEND noninteractive

#Update repo
RUN apt-get update

# Download and Install Nginx
RUN apt-get install -y nginx

# Generate SSl Cert, key
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 443

CMD service nginx start
