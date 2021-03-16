#create another 
cp /home/nour/Android/Sdk/tools/test.py /home/nour/Android/Sdk/tools/test1.py
#change the package
sed -i "s/App_Lambda_App.apk/$1/g" /home/nour/Android/Sdk/tools/test1.py
#change the main activity name
sed -i "s/com.core.lambdaapp.MainActivity/$2/g" /home/nour/Android/Sdk/tools/test1.py
#change the package name 
sed -i "s/com.core.lambdaapp/$3/g" /home/nour/Android/Sdk/tools/test1.py

