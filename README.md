# MAT PhoneGap Plugin

## Installing the Plugin

Here we have outlined several ways to include the MAT Plugin in your PhoneGap project.
You may use whichever method best fits into your build process.


### Plugman

Run the following [plugman](https://github.com/apache/cordova-plugman) command from your project's `platforms\[PLATFORM]\` folder:

    plugman install --platform [PLATFORM] --project [PROJECT-PATH] --plugin [PLUGIN-PATH]

    [PLATFORM] = android or ios
    [PROJECT-PATH] = path to folder of your phonegap project
    [PLUGIN-PATH] = path to folder of this plugin


### Cordova/PhoneGap CLI

Run the follow command-line interface commands from your project's folder:

Cordova:

    cordova plugin add [PLUGIN-PATH]

Cordova Registry:

    cordova plugin add com.mobileapptracking.matplugin

PhoneGap:

    phonegap local plugin add [PLUGIN-PATH]

### Manual Android Installation

1. Add the following to your `res/xml/config.xml` file:

        <feature name="MATPlugin" >
            <param name="android-package" value="com.mobileapptracking.MATPlugin" />
        </feature>

2. Add `com/mobileapptracking/MATPlugin.java` from MAT PhoneGap's `src/android` folder to your Android project's `src` folder.
    You may simply copy the `com` folder from repo to your `src` folder.

3. Add necessary plugin permissions to your `AndroidManifest.xml`.

        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.READ_PHONE_STATE" /> <!-- optional, for collecting device IMEI -->
        <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" /> <!-- optional, for collecting MAC address -->

4. Copy the `MATPlugin.js` file from MAT PhoneGap's `www` folder into your application's `assets/www` folder.

5. Import the MATPlugin.js script in your html file:
        
        <script type="text/javascript" src="MATPlugin.js"></script>

### Manual iOS Installation

1. Make sure the PhoneGap project exists, if not:

        phonegap create <PROJECT-NAME>

2. Make sure the iOS project has been created, if not:

        cd <PROJECT-NAME>
        phonegap build ios

3. Copy the MATPlugin.js file to the `platforms/ios/www` folder

4. Import the MATPlugin.js script in your html file:
        
        <script type="text/javascript" src="MATPlugin.js"></script>

5. Create a folder `platforms/ios/Plugins/com.mobileapptracking.MATPlugin`. 

6. Copy and paste the files -- `MATPlugin.h`, `MATPlugin.m`, `MobileAppTracker.h`, `MobileAppTracker.a` -- from the downloaded MAT plugin's `src/ios` folder.

7. Open the iOS project in Xcode.

8. In the Project Explorer, Ctrl+Click Plugins folder and click **Add Files To _"`<PROJECT-NAME>`"_**. 
   Browse to the folder mentioned in #4 above and add the `.h` and `.m` files to the project.

9. Go to the project settings Build Phase page. In the Link Binary With Libraries section add the required frameworks:

        MobileAppTracker-3.0.a -- from the folder mentioned in #4 above
        AdSupport.framework -- Optional
        CoreTelephony.framework
        MobileCoreServices.framework
        SystemConfiguration.framework
        iAd.framework


10. Copy the MATPlugin feature tag to **platforms/ios/_`<PROJECT-NAME>`_/config.xml** file.

        <feature name="MATPlugin">
            <param name="ios-package" value="MATPlugin" />
            <param name="onload" value="true" />
        </feature>
