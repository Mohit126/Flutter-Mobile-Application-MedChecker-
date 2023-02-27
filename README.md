# Medicinal Plant Checker(MedCheker) Mobile Application Using Flutter

## Introduction
This documentation explains the purpose and functionality of the "MedChecker" Flutter app. This app is designed for users to check  medicinal plant around them and to get details of the same instantly on their mobile devices.

## Architecture
The MedChecker app is built using the Flutter framework, which allows for cross-platform development. The app's architecture consists of the following components:
    • UI: The user interface is built using Flutter's Material Design widgets and includes a home screen for taking image using camara or choosing image from gallery to predict and a screen for displaying the details of the predicted plant, which include a feedback recieving feature from user.




![image](https://user-images.githubusercontent.com/33660875/221493312-fcae7f0c-6f55-45f2-9726-e7364d41fa56.png)








     Fig: It shows a predicted class details with  feedback feature enabled.
    • Data storage: The app uses the SQLite database to store details of plants and it is operated bseide the server side.
    • Server side response: A flask based server is hosting the the entire app functionalaity to predict an image recieved and give back response as wether the class is not present or provide the predicted plant details from the database as shown the above.




![image](https://user-images.githubusercontent.com/33660875/221493378-ba13cf00-45cb-4932-bc02-e461e62fecd6.png)









     Fig: If the image is out of class it will show “The class is not present” message.

## Reqired  Dependencies
The following are the dependencies required in this flutter application. Add these under the dependencies: on the pubspec.yaml file in the flutter project.

cupertino_icons: ^1.0.2
image_picker: ^0.8.6
path_provider: ^2.0.11
http: ^0.13.3
image:




## Code Documentation
The following are the key classes and functions in the MedChecker app:
    1. getImage(): 
       
	This getImage() function is defined to get image from camara or gallery.
  The 	“pickImage” library is used to take the image from source with a max size 	1024 * 1024.

       
    2. saveFilePermanently(): 
       
	This function is used to save the image as file in the device permanently.


    3. uploadImage():
       
	This function is created to uploade the image captured or taken from gallery to 	server through http  MultipartRequest.
  In the setState, notify the framework 	that the internal state of this object has changed.
  It receives the details of 	predicted class from the database.
  In this function dart:converter as 	jasonDecode, which parses the string and returns the resulting Json object.


    4. gotoSecondScreen():
       
	This function is used to navigate and  pass the values from the home screen to 	the second screen for displaying the plant details. 

    5. ChangeText():
       
  This function removes the previous output "The class is not present" from the home screen. 
  Which featured under OutlinedButton of Camara and Gallery.
       
    6. SendDataToServerRight()

	This function is defined to take positive feedback from users and it updates the 	feedback count to the database simultaneously using http request.
  This function is defined on the secondpage screen.



    7. sendDataToServerWrong()

	This function is used to take positive feedback from users and it updates the 	feedback count to the database simultaneously using http request.
  This function 	also defined on the secondpage screen.

## User Documentation
To use the My Notes app, follow these steps:
    1. Install the app on your mobile device.
    2. Launch the app to display the home screen.
    3. To take an image, tap the "Camara" or “Gallery” button and capture or choose respectively..
    4. To predict the selected image, tap the "Predict" button on the screen.
    5. If the class is present, you got the details and for updating the feedback click on the button below the page.
    6. To check another image, tap back arrow on the app bar and choose the next and click on the predict button.

## Troubleshooting
If you encounter any issues while using the My Notes app, please try the following steps:
    • Make sure that your mobile device is running the latest version of the app.
    • Check that your device has enough storage space.
    • If the app crashes, try restarting it or restarting your mobile device.
    • If you still encounter issues, contact the app's developer for support.
## Conclusion
This documentation provides an overview of the MedChecker app's purpose, architecture, code, and usage. It also includes troubleshooting information and contact details for support
