FROM  cyberdojofoundation/javascript-node:8.2.1
LABEL maintainer=jon@jaggersoft.com

# reinstall npm
RUN rm -rf /usr/local/lib/node_modules/npm
RUN n latest

RUN npm install --global jasmine-node

COPY red_amber_green.rb /usr/local/bin
