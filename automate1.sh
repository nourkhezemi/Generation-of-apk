#Define all paths, constants here
read -p "Please Enter Path of the project:" PROJECT_DIR
OUTPUT_DIR='/home/nour/APKS'
# Functions for customizing colors(Optional)
print_red(){
    printf "\e[1;31m$1\e[0m"
}
print_green(){
    printf "\e[1;32m$1\e[0m"
}
print_yellow(){
    printf "\e[1;33m$1\e[0m"
}
print_blue(){
    printf "\e[1;34m$1\e[0m"
}

#Enter project dir
cd $PROJECT_DIR
#Start Build Process
print_blue "\n\n\nStarting"


print_blue "\n\n\n build...\n"
./gradlew build

print_blue "\n\n\n assembleDebug...\n"
./gradlew assembleDebug

#Copy APK to output folder
cp "$PROJECT_DIR"/app/build/outputs/apk/debug/app-debug.apk $OUTPUT_DIR
print_blue "\n\n\n Copying APK to outputs Done\n"
