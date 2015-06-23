#!/bin/bash
if [ "$PATH" = *"java-x86_64"* ]; then
  echo "IBM SDK 6 64 bit already installed";
else
  echo "export JAVA_HOME='/opt/ibm/java-x86_64-60'" >> /home/db2inst1/.profile
  echo 'PATH=$PATH:"/opt/ibm/java-x86_64-60/bin"' >> /home/db2inst1/.profile
fi

