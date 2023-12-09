# PSscript
A powershell script to add right-mouse-click context menu item named ScaleDown that converts any picture to a 800px width JPEG.  \
The witdth can easily be adjusted in the script.

![scaleDown](https://github.com/olafesq/PSscript/assets/6490461/6e84b52f-e067-4e78-886b-49570cedea51)


# Instructions:
* Download the scaleDown.ps1 file (script) and notice the place where you save it.
* Create new Reg Entry: Computer\HKEY_CLASSES_ROOT\*\shell\ScaleDown\command
* Define Default value: cmd /c start /min "" powershell  -WindowStyle hidden -Command "& C:\Users\olafe\Documents\PSscript\scaleDown.ps1" '%1'

Notice to change the path to the scaleDown.ps1 script location with the location you saved the script!

Enjoy!

