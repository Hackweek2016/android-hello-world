#!/bin/bash

# Solano CI pre_setup hook 

# Only trigger the android SDK download if it is not already installed
if ! test -d $ANDROID_HOME; then
  (cd ~ && curl http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz | tar zxv)

  # Set the minimal list of packages required
  packages="platform-tools,android-22,build-tools-22.0.1,extra"  

  expect -c "
  set timeout -1 ;
  spawn $ANDROID_HOME/tools/android update sdk --no-ui --all --filter $packages; 
  expect { 
    \"Do you accept the license\" { exp_send \"y\r\" ; exp_continue }
    eof
  }
  "
fi

# Ensure gradle is installed
./gradlew clean
