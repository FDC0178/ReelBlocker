#!/usr/bin/env sh

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if ${cygwin} ; then
  [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`"/$link"
  fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

# Attempt to set JAVA_HOME if it is not set
if [ -z "$JAVA_HOME" ]; then
    # If we are on Darwin, try to find a JDK
    if [ "$darwin" = "true" ]; then
        # If we are on Darwin, we may have a JAVA_HOME specified in /etc/java_home.
        if [ -x '/usr/libexec/java_home' ] ; then
            export JAVA_HOME=`/usr/libexec/java_home`
        # Otherwise, we might have a fallback.
        elif [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ]; then
            export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
        fi
    else
        # For other operating systems, we will just have to assume that 'java' is on the path.
        java_cmd="java"
    fi

    if [ -z "$JAVA_HOME" ]; then
        if [ -n "$java_cmd" ]; then
            # Check if 'java' is on the path.
            java_executable=`which java 2>/dev/null`
            if [ -z "$java_executable" ]; then
                echo "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH." >&2
                echo "" >&2
                echo "Please set the JAVA_HOME variable in your environment to match the" >&2
                echo "location of your Java installation." >&2
                exit 1
            fi
        fi
    fi
fi

# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
  if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
    # IBM's JDK on AIX uses strange locations for the executables
    JAVACMD="$JAVA_HOME/jre/sh/java"
  else
    JAVACMD="$JAVA_HOME/bin/java"
  fi
  if [ ! -x "$JAVACMD" ] ; then
    die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
  fi
else
  JAVACMD="java"
  which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum number of open file descriptors on OS X
if [ "$darwin" = "true" ]; then
    if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ]; then
        # Use the maximum available.
        MAX_FD=`ulimit -H -n`
    fi
    ulimit -n $MAX_FD
fi

# Add -d64 to JAVA_OPTS if 64bit JVM is available and 32bit is not
if [ "$darwin" = "true" ]; then
    if [ -z "`echo $JAVA_OPTS | grep d64`" -a -d "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/java" -a ! -d "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home/bin/java" ]; then
        JAVA_OPTS="-d64 $JAVA_OPTS"
    fi
fi

# Add the jar to the classpath
CLASSPATH="$APP_HOME/gradle/wrapper/gradle-wrapper.jar"

# Execute Gradle
exec "$JAVACMD" \
  $DEFAULT_JVM_OPTS \
  $JAVA_OPTS \
  $GRADLE_OPTS \
  "-Dorg.gradle.appname=$APP_BASE_NAME" \
  -classpath "$CLASSPATH" \
  org.gradle.wrapper.GradleWrapperMain \
  "$@"
