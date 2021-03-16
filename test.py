# Imports the monkeyrunner modules used by this program
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice

# sets a variable with the apk name
apk='/home/nour/APKS/App_Lambda_App.apk'
# sets a variable with the name of an Activity in the package
activity ='com.core.lambdaapp.MainActivity'
#set the package name
package = 'com.core.lambdaapp'


# Connects to the current device, returning a MonkeyDevice object
print("connecting device...")
device = MonkeyRunner.waitForConnection()

# Installs the Android package. Notice that this method returns a boolean, so you can test
# to see if the installation worked.
print("installing app...")
print("give APK path")

device.installPackage(apk)

print("launching app...")


#print("give package name")
#p=raw_input()
#print("give MainActivity name")
#a=raw_input()





# sets the name of the component to start
runComponent = package +"/"+ activity

# Runs the component
device.startActivity(component=runComponent)
print('touch  button')
# Presses the Menu button
device.press('KEYCODE_MENU', MonkeyDevice.DOWN_AND_UP)
######
#PRESS SOME KEYS 
device.press('KEYCODE_MOVE_END', MonkeyDevice.DOWN_AND_UP)
device.press('KEYCODE_DEL', MonkeyDevice.DOWN_AND_UP)
device.press('KEYCODE_DEL', MonkeyDevice.DOWN_AND_UP)
device.press('KEYCODE_DEL', MonkeyDevice.DOWN_AND_UP)
device.type('12.2')
device.press('KEYCODE_TAB', MonkeyDevice.DOWN_AND_UP)
device.press('KEYCODE_MOVE_END', MonkeyDevice.DOWN_AND_UP)
device.press('KEYCODE_DEL', MonkeyDevice.DOWN_AND_UP)
device.type('1')
for num in range(1,1000):
  device.touch(560,400, 'DOWN_AND_UP')
  

# Takes a screenshot

result = device.takeSnapshot()
print('taking screenshot ...')
# Writes the screenshot to a file
result.writeToFile('/home/nour/Downloads/shot.png','png')
print('screenshot done ...')
