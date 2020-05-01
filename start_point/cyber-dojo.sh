# set the version to use:
#NODE_VERSION=0.12.7
#NODE_VERSION=4.1.1
#NODE_VERSION=4.2.1
#NODE_VERSION=6.11.1
#NODE_VERSION=8.2.1
#NODE_VERSION=8.4.0
#NODE_VERSION=9.4.0
#NODE_VERSION=9.10.1
#NODE_VERSION=10.1.0
#NODE_VERSION=13.7.0
NODE_VERSION=14.1.0

# Use npm package 'n' to call jshint and jasmine with selected node version:
if [ -f .jshintrc ]; then
  n use $NODE_VERSION \
    /usr/lib/node_modules/jshint/bin/jshint \
    --config .jshintrc \
    *.js
fi

if [ $? == 0 ]; then
  n use $NODE_VERSION \
    /usr/local/lib/node_modules/jasmine/bin/jasmine \
    JASMINE_CONFIG_PATH=./jasmine.json
fi
