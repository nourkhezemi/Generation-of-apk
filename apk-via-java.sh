#!/usr/bin/bash

#PREPARE ENVIRONMENT

CD=$1

rm -r bin
rm -r gen
mkdir bin
mkdir gen

# Set your application name
APP_NAME=$1

# Define minimal Android revision
ANDROID_REV=android-21

# Define aapt add command
ANDROID_AAPT_ADD="$ANDROID_HOME/build-tools/21.1.2/aapt add"

# Define aapt pack and generate resources command
ANDROID_AAPT_PACK="$ANDROID_HOME/build-tools/21.1.2/aapt package -v -f -I $ANDROID_HOME/platforms/$ANDROID_REV/android.jar"

# Define class file generator command
ANDROID_DX="$ANDROID_HOME/build-tools/21.1.2/dx --dex"

# Define Java compiler command
JAVAC="$JAVA_HOME/bin/javac  -classpath $ANDROID_HOME/platforms/$ANDROID_REV/android.jar"
JAVAC_BUILD="$JAVAC -sourcepath src -sourcepath gen -d bin"


##################################################################
#  PROCESS
##################################################################

#Have the name of the package 
pkg=`grep -Po '(?<=package=)"[^"]*"' $1/app/src/main/AndroidManifest.xml`

# Generate R class and pack resources and assets into resources.ap_ file
$ANDROID_AAPT_PACK -M "AndroidManifest.xml" -A "$1/app/src/main/assets" -S "$1/app/src/main/res" -m -J "gen" -F "bin/resources.ap_"

p=$(echo $pkg | tr  -s '.' '/' | tr  -d '"') 
#echo $p
# Compile sources. All *.class files will be put into the bin folder

rm -r obj
mkdir obj
$JAVAC_BUILD $CD/app/src/main/java/$p/*.java

# Generate dex files with compiled Java classes
$ANDROID_DX --output="$CD/bin/classes.dex" /home

# Recources file need to be copied. This is needed for signing.
mv "$CD/bin/resources.ap_" "$CD/bin/$APP_NAME.ap_"

# Add generated classes.dex file into application package
$ANDROID_AAPT_ADD "$CD/bin/p.ap_" "$CD/bin/classes.dex"

# Create signed Android application from *.ap_ file. Output and Input files must be different.
"$JAVA_HOME/bin/jarsigner" -keystore "/home/nour/key.keystore" -storepass "motdepasse123" -keypass "motdepasse123" -signedjar "$CD/bin/p.apk" "$CD/bin/$APP_NAME.ap_" "okalash-android-key"

# Delete temp file
rm "bin/p.ap_"

