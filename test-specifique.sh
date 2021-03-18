
print_blue(){
    printf "\e[1;34m$1\e[0m"
}
#GET APK

read -p "give the path of the main apk " APK
read -p "give the path of the apk of test " APKT

#INSTALL APK
print_blue "\n\n\nInstalling APK"
adb install $APK
adb install $APKT

#Run TESTS
print_blue "\n\n\nRunning Tests"
adb logcat -c
u="$(adb shell pm list instrumentation)"
part=(${u//instrumentation:/})
adb shell am instrument -w ${part[0]}
print_blue "Finish"

#SAVE LOGS
print_blue "\n\n\nSaving logs"
adb logcat -d >> $APK.txt  

#UNISNTALL APP
print_blue "\n\n\nuninstalling app"
package1=`aapt dump badging $APK | grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g`
package2=`aapt dump badging $APKT | grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g`
adb shell pm uninstall $package1
adb shell pm uninstall $package2

