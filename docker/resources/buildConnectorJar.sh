#!/usr/bin/sh

## call this script to use maven to build the spark connector jar file from the pom.xml

POM_FILE="$(pwd)"/pom.xml

mvn -B --fail-never dependency:resolve && \
    mvn -B --fail-never package;

# you may want to clean the "$(pwd)"/target file
# you may want to clean the cache  "rm -rf ~/.m2/" of your current user.
