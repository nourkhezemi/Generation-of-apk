#move to home diractory
cd /home/nour
#give the apk path
read -p "give the apk path"  apk
#give the main activity name
read -p "give the main activity name"  activity
#give the package name
read -p "give the package name"  package
#remplacer les apk, activity, package dans test.py and create a copie
./parametrisation.sh $apk $activity $package
#
cd /home/nour/Android/Sdk/tools/bin
#run the monkey runner
./monkeyrunner /home/nour/Android/Sdk/tools/test1.py
#generate the logs
adb logcat > /home/nour/logs/$package.txt
