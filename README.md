# MAT PhoneGap Plugin

The MobileAppTracking (MAT) Plugin for PhoneGap provides basic application install
and event tracking functionality.

To track installs, you must first integrate the PhoneGap plugin with your app.
You may also add and track additional events beyond an app install (such as purchases,
game levels, and any other user engagement).

This document outlines the MAT PhoneGap plugin integration.


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

        MobileAppTracker.a -- from the folder mentioned in #4 above
        AdSupport.framework -- Optional
        CoreTelephony.framework
        MobileCoreServices.framework
        SystemConfiguration.framework


10. Copy the MATPlugin feature tag to **platforms/ios/_`<PROJECT-NAME>`_/config.xml** file.

        <feature name="MATPlugin">
            <param name="ios-package" value="MATPlugin" />
            <param name="onload" value="true" />
        </feature>


## Integration

Now that the plugin is installed, here are instructions on how to use the MobileAppTracking plugin.

For a complete example, see the implementation in the `example/www/index.html` file of the plugin folder.

The MobileAppTracking methods are available in a window.plugins.matPlugin object.

You can create a JavaScript var to easily access the MAT object defined in MATPlugin.js:

    var mat = window.plugins.matPlugin;

The MAT object can be used to call methods defined in MatPlugin.js.

After receiving your `deviceready` event, initialize the MAT tracker with the `initTracker` function, passing in
a success callback, error callback, your MAT advertiser ID and key:

    mat.initTracker(success, failure, "advertiser_id","advertiser_key");

### Installs and Updates

As the success of attributing app events after the initial install is dependent upon first tracking that install, 
we require that the install is the first event tracked. To track install of your mobile app, use the `trackInstall` 
method. If users have already installed your app prior to SDK implementation, then these users should be tracked as updates.

#### Track Installs

To track installs of your mobile app, use the Track Install method. Track Install is used to track when users install your 
mobile app on their device and will only record one conversion per install in reports.

    mat.trackInstall(success, failure);

The `trackInstall` method automatically tracks updates of your app if the app version differs from the last app version it saw.

#### Handling Installs Prior to SDK Implementation - Track as Updates

What if your app already has thousands or millions of users prior to SDK implementation? What happens when these users update 
the app to the new version that contains the MAT SDK?

MAT provides you two ways to make sure that the existing users do not count towards new app installs.

1. Call SDK method `trackUpdate` instead of `trackInstall`.

    If you are integrating MAT into an existing app where you have users you’ve seen before, you can track an update yourself with the `trackUpdate` method.

    mat.trackUpdate(success, failure);

2. Import prior installs to the platform.

These methods are useful if you already have an app in the store and plan to add the MAT SDK in a new version. 
Learn how to [handle installs prior to SDK implementation here](http://support.mobileapptracking.com/entries/22621001-Handling-Installs-prior-to-SDK-implementation).

If the code used to differentiate installs versus app updates is not properly implemented, then you will notice 
a [spike of total installs](http://support.mobileapptracking.com/entries/22900598-Spike-of-Total-Installs-on-First-day-of-SDK) on the first day of the SDK implementation.


### Events

After the install has been tracked, the `trackAction` method is intended to be used to track user actions such as reaching a 
certain level in a game or making an in-app purchase. The `trackAction` method allows you to define the event name dynamically.

    trackAction(success, failure, eventName, isId, referenceId, revenue, currency)

where

    success = success callback
    failure = failure callback
    eventName = name of event to track
    isId = whether eventName is passing event name or event ID # from MAT
    referenceId = advertiser ref ID to associate with event
    revenue = revenue amount to associate with event as double
    currency = ISO 4217 currency code of revenue

You need to supply the "eventName" field with the appropriate value for the event; e.g. "registration". If the event does
not exist, it will be dynamically created in our site. You may pass a revenue value, currency code,
or whether you are using an event ID or event name, as optional fields.

#### Registration

If you have a registration process, it's recommended to track it by calling trackAction set to "registration".

    mat.trackAction(success, failure, "registration", false, "some_username", 0, "USD");

You can find these events in the platform by viewing Reports > Event Logs. Then filter the report by the "registration" event.

While our platform always blocks the tracking of duplicate installs, by default it does not block duplicate event requests. 
However, a registration event may be an event that you only want tracked once per device/user. 
Please see [block duplicate requests setting for events](http://support.mobileapptracking.com/entries/22927312-Block-Duplicate-Request-Setting-for-Events) for further information.

#### Purchases

The best way to analyze the value of your publishers and marketing campaigns is to track revenue from in-app purchases.
By tracking in-app purchases for a user, the data can be correlated back to the install and analyzed on a cohort basis 
to determine revenue per install and lifetime value.

    mat.trackAction(success, failure, "purchase", false, "", 0.99, "USD");

__Track In-App Purchases__
The basic way to track purchases is to track an event with a name of purchase and then define the revenue (sale amount) and currency code.

__Note__: Pass the revenue in as a Double and the currency of the amount if necessary.  Currency is set to "USD" by default.
See [Setting Currency Code](http://support.mobileapptracking.com/entries/23697946-Customize-SDK-Settings) for currencies we support.

You can find these events in platform by viewing Reports > Logs > Events. Then filter the report by the "purchase" event.

#### Opens

The SDK allows you to analyze user engagement by tracking unique opens. The SDK has built in functionality to only track one "open" event
per user on any given day to minimize footprint. All subsequent "open" events fired on the same day are ignored and will not show up on the platform.

    mat.trackAction(success, failure, "open", false, "", 0, "USD");

You can find counts of Opens by viewing Reports > Mobile Apps. Include the parameter of Opens to see the aggregated count.
The platform does not provide logs of Opens. If you track Opens using a name other than "open" then these tracked events will
cost the same price as all other events to track.

#### Other Events

You can track other events in your app dynamically by calling `trackAction`. The `trackAction` method is intended for tracking
any user actions. This method allows you to define the event name.

To dynamically track an event, replace "eventName" with the name of the event you want to track. The tracking engine
will then look up the event by the name. If an event with the defined name doesn’t exist, the tracking engine will automatically
create an event for you with that name. An Event Name has to be alphanumeric.

You can find these events in platform by viewing Reports->Logs->Event Logs.

The max event limit per site is 100. Learn more about the [max limit of events](http://support.mobileapptracking.com/entries/22803093-Max-Event-Limit-per-Site).

While our platform always blocks the tracking of duplicate installs, by default it does not block duplicate event requests. 
However, there may be other types of events that you only want tracked once per device/user. Please see [block duplicate requests setting for events](http://support.mobileapptracking.com/entries/22927312-Block-Duplicate-Request-Setting-for-Events) for further information.


### Testing Plugin Integration with SDK

These pages contain instructions on how to test whether the SDKs were successfully implemented for the various platforms:

[Testing Android SDK Integration](http://support.mobileapptracking.com/entries/22541781-Testing-Android-SDK-integration)

[Testing iOS SDK Integration](http://support.mobileapptracking.com/entries/22561876-testing-ios-sdk-integration)


### Debug Mode and Duplicates

__Debugging__

When the Debug mode is enabled in the SDK, the server responds with debug information about the success or failure of the
tracking requests.

__Note__: For Android, debug mode log output can be found in LogCat under the tag "MobileAppTracker".

To debug log messages that show the event status and server response, call the `setDebugMode` method with Boolean true:

    mat.setDebugMode(success, failure, true);

__Allow Duplicates__

The platform rejects installs from devices it has seen before.  For testing purposes, you may want to bypass this behavior
and fire multiple installs from the same testing device.
 
There are two methods you can employ to do so: (1) calling the `setAllowDuplicates` method, and (2) set up a test profile.

(1) Call the `setAllowDuplicates` after initializing `MobileAppTracker`, with Boolean true:

    mat.setAllowDuplicates(success, failure, true);

(2) Set up a [test profile](http://support.mobileapptracking.com/entries/22541401-Test-Profiles). A Test Profile should be 
used when you want to allow duplicate installs and/or events from a device you are using from testing and don't want to 
implement setAllowDuplicateRequests in the code and instead allow duplicate requests from the platform.


**_The setDebugMode and setAllowDuplicates calls are meant for use only during debugging and testing. Please be sure to disable these for release builds._**


### Additional Resources

#### Custom Settings

The SDK supports several custom identifiers that you can use as alternate means to identify your installs or events.
Call these setters before calling the corresponding trackInstall or trackAction code.

__OpenUDID__ (iOS only)

This sets the OpenUDID of the device. Can be generated with the official implementation at [http://OpenUDID.org](http://OpenUDID.org).
Calling this will do nothing on Android apps.

    mat.setOpenUDID(success, failure, "your_open_udid");

__TRUSTe ID__

If you are integrating with the TRUSTe SDK, you can pass in your TRUSTe ID with `setTRUSTeId`, which populates the "TPID" field.

    mat.setTrusteTPID(success, failure, "your_truste_id");

__User ID__

If you have a user ID of your own that you wish to track, pass it in as a string with `setUserId`. This populates the "User ID"
field in our reporting, and also the postback variable {user_id}.

    mat.setUserId(success, failure, "custom_user_id");

The SDK supports several custom identifiers that you can use as alternate means to identify your installs or events.
Please navigate to the [Custom SDK Settings](http://support.mobileapptracking.com/entries/23738686-Customize-SDK-Settings) page for more information.

#### Event Items

While an event is like your receipt for a purchase, the event items are the individual items you purchased.
Event items allow you to define multiple items for a single event. The `trackAction` method can include this event item data.

The function for tracking event items looks like this:

    trackActionWithItems(success, failure, eventName, isId, items, referenceId, revenue, currency)

items is an array of "event items" that have the following format:

    {
     "item":"item_name",    // name of the item
     "quantity":1,          // # of items
     "unit_price":0.99,     // individual unit price
     "revenue":0.99,        // total revenue of event item, defaults to quantity x unit price
     "attribute_sub1":"1",  // attribute1 for your use (optional)
     "attribute_sub2":"2",  // attribute2 for your use (optional)
     "attribute_sub3":"3",  // attribute3 for your use (optional)
     "attribute_sub4":"4",  // attribute4 for your use (optional)
     "attribute_sub5":"5"   // attribute5 for your use (optional)
    }

Sample tracking code:

    var eventItems = new Array();

    var eventItem1 = {
                      "item":"apple",
                      "quantity":1,
                      "unit_price":0.99,
                      "revenue":0.99,
                      "attribute_sub1":"1",
                      "attribute_sub2":"2",
                      "attribute_sub3":"3",
                      "attribute_sub4":"4",
                      "attribute_sub5":"5"
                     };
    eventItems[0] = eventItem1;
                
    var eventItem2 = {
                      "item":"banana",
                      "quantity":2,
                      "unit_price":0.50,
                      "revenue":1
                     };
    eventItems[1] = eventItem2;
                
    mat.trackActionWithItems(
                             success,
                             failure,
                             "purchase",
                             false,
                             eventItems,
                             "ref1",
                             0.99,
                             "USD"
                            );
