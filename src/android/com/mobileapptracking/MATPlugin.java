package com.mobileapptracking;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageManager;
import android.provider.Settings.Secure;
import android.telephony.TelephonyManager;

import com.mobileapptracker.Encryption;
import com.mobileapptracker.MATEventItem;
import com.mobileapptracker.MATResponse;
import com.mobileapptracker.MobileAppTracker;

public class MATPlugin extends CordovaPlugin {
    public static final String INIT = "initTracker";
    public static final String MEASUREACTION = "measureAction";
    public static final String MEASUREACTIONWITHITEMS = "measureActionWithItems";
    public static final String MEASUREACTIONWITHRECEIPT = "measureActionWithReceipt";
    public static final String MEASURESESSION = "measureSession";
    public static final String SETAGE = "setAge";
    public static final String SETANDROIDID = "setAndroidId";
    public static final String SETANDROIDIDMD5 = "setAndroidIdMd5";
    public static final String SETANDROIDIDSHA1 = "setAndroidIdSha1";
    public static final String SETANDROIDIDSHA256 = "setAndroidIdSha256";
    public static final String SETAPPADTRACKING = "setAppAdTracking";
    public static final String SETALLOWDUP = "setAllowDuplicates";
    public static final String SETDEBUG = "setDebugMode";
    public static final String SETDELEGATE = "setDelegate";
    public static final String SETDEVICEID = "setDeviceId";
    public static final String SETEMAILCOLLECTION = "setEmailCollection";
    public static final String SETEVENTATTRIBUTE1 = "setEventAttribute1";
    public static final String SETEVENTATTRIBUTE2 = "setEventAttribute2";
    public static final String SETEVENTATTRIBUTE3 = "setEventAttribute3";
    public static final String SETEVENTATTRIBUTE4 = "setEventAttribute4";
    public static final String SETEVENTATTRIBUTE5 = "setEventAttribute5";
    public static final String SETEVENTCONTENTID = "setEventContentId";
    public static final String SETEVENTCONTENTTYPE = "setEventContentType";
    public static final String SETEVENTDATE1 = "setEventDate1";
    public static final String SETEVENTDATE2 = "setEventDate2";
    public static final String SETEVENTLEVEL = "setEventLevel";
    public static final String SETEVENTQUANTITY = "setEventQuantity";
    public static final String SETEVENTRATING = "setEventRating";
    public static final String SETEVENTSEARCHSTRING = "setEventSearchString";
    public static final String SETEXISTINGUSER = "setExistingUser";
    public static final String SETFBEVENTLOGGING = "setFacebookEventLogging";
    public static final String SETGENDER = "setGender";
    public static final String SETGOOGLEADVERTISINGID = "setGoogleAdvertisingId";
    public static final String SETLOCATION = "setLocation";
    public static final String SETLOCATIONWITHALTITUDE = "setLocationWithAltitude";
    public static final String SETPACKAGENAME = "setPackageName";
    public static final String SETPAYINGUSER = "setPayingUser";
    public static final String SETTPID = "setTRUSTeID";
    public static final String SETUSEREMAIL = "setUserEmail";
    public static final String SETUSERID = "setUserId";
    public static final String SETUSERNAME = "setUserName";
    public static final String SETFBUSERID = "setFacebookUserId";
    public static final String SETTWUSERID = "setTwitterUserId";
    public static final String SETGGUSERID = "setGoogleUserId";
    public static final String CHECKDEFERREDDEEPLINK = "checkForDeferredDeeplink";
    public static final String GETMATID = "getMatId";
    public static final String GETOPENLOGID = "getOpenLogId";
    public static final String GETISPAYINGUSER = "getIsPayingUser";
    
    private MobileAppTracker tracker;
    
    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        try {
            if (INIT.equals(action)) {
                String advertiserId = args.getString(0);
                String advertiserKey = args.getString(1);
                if (advertiserId != null && advertiserId.length() > 0 && advertiserKey != null && advertiserKey.length() > 0) {
                    cordova.getThreadPool().execute(new InitThread(this.cordova.getActivity(), advertiserId, advertiserKey, callbackContext));
                    return true;
                } else {
                    callbackContext.error("Advertiser id or key is null or empty");
                    return false;
                }
            } else if (MEASURESESSION.equals(action)) {
                cordova.getThreadPool().execute(new Runnable() {
                    public void run() {
                        if (tracker != null) {
                            tracker.measureSession();
                        }
                        callbackContext.success();
                    }
                });
                return true;
            } else if (MEASUREACTION.equals(action)) {
                String eventName = args.getString(0);
                String refId = null;
                double revenue = 0;
                String currency = null;
                
                try {
                    refId = args.getString(1);
                    revenue = args.getDouble(2);
                    currency = args.getString(3);
                } catch (JSONException e) {
                }
                
                if (eventName != null && eventName.length() > 0) {
                    cordova.getThreadPool().execute(new MeasureActionThread(eventName, revenue, currency, refId, null, null, null, callbackContext));
                    return true;
                } else {
                    callbackContext.error("Event name null or empty");
                    return false;
                }
            } else if (MEASUREACTIONWITHITEMS.equals(action) || MEASUREACTIONWITHRECEIPT.equals(action)) {
                String eventName = args.getString(0);
                String refId = null;
                double revenue = 0;
                String currency = null;
                JSONArray eventItems = new JSONArray();
                String receiptData = null;
                String receiptSignature = null;
                try {
                    eventItems = args.getJSONArray(1);
                    refId = args.getString(2);
                    revenue = args.getDouble(3);
                    currency = args.getString(4);
                    receiptData = args.getString(6);
                    receiptSignature = args.getString(7);
                } catch (JSONException e) {
                }
                
                // Convert JSONArray of JSONObjects into List of MATEventItems
                List<MATEventItem> eventItemList = new ArrayList<MATEventItem>();
                for (int i = 0; i < eventItems.length(); i++) {
                    JSONObject item = eventItems.getJSONObject(i);
                    if (!item.has("item")) {
                        // If event item missing item name, go to next item
                        continue;
                    }
                    String name = item.getString("item");
                    int quantity = 0;
                    double unitPrice = 0;
                    double itemRevenue = 0;
                    String attribute_sub1 = null;
                    String attribute_sub2 = null;
                    String attribute_sub3 = null;
                    String attribute_sub4 = null;
                    String attribute_sub5 = null;
                    
                    if (item.has("quantity")) {
                        quantity = item.getInt("quantity");
                    }
                    if (item.has("unit_price")) {
                        unitPrice = item.getDouble("unit_price");
                    }
                    if (item.has("revenue")) {
                        itemRevenue = item.getDouble("revenue");
                    }
                    
                    if (item.has("attribute_sub1")) {
                        attribute_sub1 = item.getString("attribute_sub1");
                    }
                    if (item.has("attribute_sub2")) {
                        attribute_sub2 = item.getString("attribute_sub2");
                    }
                    if (item.has("attribute_sub3")) {
                        attribute_sub3 = item.getString("attribute_sub3");
                    }
                    if (item.has("attribute_sub4")) {
                        attribute_sub4 = item.getString("attribute_sub4");
                    }
                    if (item.has("attribute_sub5")) {
                        attribute_sub5 = item.getString("attribute_sub5");
                    }
                    
                    MATEventItem eventItem = new MATEventItem(name,
                                                              quantity,
                                                              unitPrice,
                                                              itemRevenue,
                                                              attribute_sub1,
                                                              attribute_sub2,
                                                              attribute_sub3,
                                                              attribute_sub4,
                                                              attribute_sub5);
                    eventItemList.add(eventItem);
                }
                
                if (eventName != null && eventName.length() > 0) {
                    cordova.getThreadPool().execute(new MeasureActionThread(eventName, revenue, currency, refId, eventItemList, receiptData, receiptSignature, callbackContext));
                    return true;
                } else {
                    callbackContext.error("Event name null or empty");
                    return false;
                }
            } else if (SETAGE.equals(action)) {
                int age = args.getInt(0);
                if (tracker != null) {
                    tracker.setAge(age);
                }
                callbackContext.success();
                return true;
            } else if (SETALLOWDUP.equals(action)) {
                boolean allowDups = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setAllowDuplicates(allowDups);
                }
                callbackContext.success();
                return true;
            } else if (SETANDROIDID.equals(action)) {
                boolean enableAndroidId = args.getBoolean(0);
                if (tracker != null && enableAndroidId) {
                    String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                    tracker.setAndroidId(androidId);
                }
                callbackContext.success();
                return true;
            } else if (SETANDROIDIDMD5.equals(action)) {
                boolean enableAndroidIdMd5 = args.getBoolean(0);
                if (tracker != null && enableAndroidIdMd5) {
                    String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                    tracker.setAndroidIdMd5(Encryption.md5(androidId));
                }
                callbackContext.success();
                return true;
            } else if (SETANDROIDIDSHA1.equals(action)) {
                boolean enableAndroidIdSha1 = args.getBoolean(0);
                if (tracker != null && enableAndroidIdSha1) {
                    String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                    tracker.setAndroidIdSha1(Encryption.sha1(androidId));
                }
                callbackContext.success();
                return true;
            } else if (SETANDROIDIDSHA256.equals(action)) {
                boolean enableAndroidIdSha256 = args.getBoolean(0);
                if (tracker != null && enableAndroidIdSha256) {
                    String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                    tracker.setAndroidIdSha256(Encryption.sha256(androidId));
                }
                callbackContext.success();
                return true;
            } else if (SETAPPADTRACKING.equals(action)) {
                boolean adTracking = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setAppAdTrackingEnabled(adTracking);
                }
                callbackContext.success();
                return true;
            } else if (SETDEBUG.equals(action)) {
                boolean debug = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setDebugMode(debug);
                }
                callbackContext.success();
                return true;
            } else if (SETDEVICEID.equals(action)) {
                boolean enableDeviceId = args.getBoolean(0);
                if (tracker != null && enableDeviceId) {
                    // Check for READ_PHONE_STATE permission
                    String permission = "android.permission.READ_PHONE_STATE";
                    int res = this.cordova.getActivity().getApplicationContext().checkCallingOrSelfPermission(permission);
                    if (res == PackageManager.PERMISSION_GRANTED) {
                        TelephonyManager telephonyManager = (TelephonyManager)this.cordova.getActivity().getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
                        tracker.setDeviceId(telephonyManager.getDeviceId());
                    }
                }
                callbackContext.success();
                return true;
            } else if (SETEMAILCOLLECTION.equals(action)) {
                boolean collectEmail = args.getBoolean(0);
                if (tracker != null && collectEmail) {
                    tracker.setEmailCollection(collectEmail);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTATTRIBUTE1.equals(action)) {
                String attributeVal = args.getString(0);
                if (tracker != null) {
                    tracker.setEventAttribute1(attributeVal);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTATTRIBUTE2.equals(action)) {
                String attributeVal = args.getString(0);
                if (tracker != null) {
                    tracker.setEventAttribute2(attributeVal);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTATTRIBUTE3.equals(action)) {
                String attributeVal = args.getString(0);
                if (tracker != null) {
                    tracker.setEventAttribute3(attributeVal);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTATTRIBUTE4.equals(action)) {
                String attributeVal = args.getString(0);
                if (tracker != null) {
                    tracker.setEventAttribute4(attributeVal);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTATTRIBUTE5.equals(action)) {
                String attributeVal = args.getString(0);
                if (tracker != null) {
                    tracker.setEventAttribute5(attributeVal);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTCONTENTID.equals(action)) {
                String contentId = args.getString(0);
                if (contentId != null && contentId.length() > 0) {
                    if (tracker != null) {
                        tracker.setEventContentId(contentId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("EventContentId null or empty");
                    return false;
                }
            } else if (SETEVENTCONTENTTYPE.equals(action)) {
                String contentType = args.getString(0);
                if (contentType != null && contentType.length() > 0) {
                    if (tracker != null) {
                        tracker.setEventContentType(contentType);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("EventContentId null or empty");
                    return false;
                }
            } else if (SETEVENTDATE1.equals(action)) {
                double dateMillis = args.getDouble(0);
                if (tracker != null) {
                    tracker.setEventDate1(new Date((long)dateMillis));
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTDATE2.equals(action)) {
                double dateMillis = args.getDouble(0);
                if (tracker != null) {
                    tracker.setEventDate2(new Date((long)dateMillis));
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTLEVEL.equals(action)) {
                int level = args.getInt(0);
                if (tracker != null) {
                    tracker.setEventLevel(level);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTQUANTITY.equals(action)) {
                int quantity = args.getInt(0);
                if (tracker != null) {
                    tracker.setEventQuantity(quantity);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTRATING.equals(action)) {
                double rating = args.getDouble(0);
                if (tracker != null) {
                    tracker.setEventRating((float)rating);
                }
                callbackContext.success();
                return true;
            } else if (SETEVENTSEARCHSTRING.equals(action)) {
                String searchString = args.getString(0);
                if (searchString != null && searchString.length() > 0) {
                    if (tracker != null) {
                        tracker.setEventSearchString(searchString);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("EventSearchString null or empty");
                    return false;
                }
            } else if (SETEXISTINGUSER.equals(action)) {
                boolean existingUser = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setExistingUser(existingUser);
                }
                callbackContext.success();
                return true;
            } else if (SETFBEVENTLOGGING.equals(action)) {
                boolean fbEventLogging = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setFacebookEventLogging(this.cordova.getActivity(), fbEventLogging);
                }
                callbackContext.success();
                return true;
            } else if (SETGENDER.equals(action)) {
                int gender = args.getInt(0);
                if (tracker != null) {
                    tracker.setGender(gender);
                }
                callbackContext.success();
                return true;
            } else if (SETGOOGLEADVERTISINGID.equals(action)) {
                String googleAid = args.getString(0);
                boolean isLAT = args.getBoolean(1);
                if (tracker != null) {
                    tracker.setGoogleAdvertisingId(googleAid, isLAT);
                }
                callbackContext.success();
                return true;
            } else if (SETLOCATION.equals(action)) {
                double latitude = args.getDouble(0);
                double longitude = args.getDouble(1);
                if (tracker != null) {
                    tracker.setLatitude(latitude);
                    tracker.setLongitude(longitude);
                }
                callbackContext.success();
                return true;
            } else if (SETLOCATIONWITHALTITUDE.equals(action)) {
                double latitude = args.getDouble(0);
                double longitude = args.getDouble(1);
                double altitude = args.getDouble(2);
                if (tracker != null) {
                    tracker.setLatitude(latitude);
                    tracker.setLongitude(longitude);
                    tracker.setAltitude(altitude);
                }
                callbackContext.success();
                return true;
            } else if (SETPACKAGENAME.equals(action)) {
                String packageName = args.getString(0);
                if (packageName != null && packageName.length() > 0) {
                    if (tracker != null) {
                        tracker.setPackageName(packageName);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("Package name null or empty");
                    return false;
                }
            } else if (SETPAYINGUSER.equals(action)) {
                boolean payingUser = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setIsPayingUser(payingUser);
                }
                callbackContext.success();
                return true;
            } else if (SETTPID.equals(action)) {
                String tpid = args.getString(0);
                if (tpid != null && tpid.length() > 0) {
                    if (tracker != null) {
                        tracker.setTRUSTeId(tpid);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("TPID null or empty");
                    return false;
                }
            } else if (SETUSEREMAIL.equals(action)) {
                String userEmail = args.getString(0);
                if (userEmail != null && userEmail.length() > 0) {
                    if (tracker != null) {
                        tracker.setUserEmail(userEmail);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("User email null or empty");
                    return false;
                }
            } else if (SETUSERID.equals(action)) {
                String userId = args.getString(0);
                if (userId != null && userId.length() > 0) {
                    if (tracker != null) {
                        tracker.setUserId(userId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("User ID null or empty");
                    return false;
                }
            } else if (SETUSERNAME.equals(action)) {
                String userName = args.getString(0);
                if (userName != null && userName.length() > 0) {
                    if (tracker != null) {
                        tracker.setUserName(userName);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("User name null or empty");
                    return false;
                }
            } else if (SETFBUSERID.equals(action)) {
                String userId = args.getString(0);
                if (userId != null && userId.length() > 0) {
                    if (tracker != null) {
                        tracker.setFacebookUserId(userId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("FB User ID null or empty");
                    return false;
                }
            } else if (SETTWUSERID.equals(action)) {
                String userId = args.getString(0);
                if (userId != null && userId.length() > 0) {
                    if (tracker != null) {
                        tracker.setTwitterUserId(userId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("TW User ID null or empty");
                    return false;
                }
            } else if (SETGGUSERID.equals(action)) {
                String userId = args.getString(0);
                if (userId != null && userId.length() > 0) {
                    if (tracker != null) {
                        tracker.setGoogleUserId(userId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("G+ User ID null or empty");
                    return false;
                }
            } else if (CHECKDEFERREDDEEPLINK.equals(action)) {
                final int timeout = args.getInt(0);
                cordova.getThreadPool().execute(new Runnable() {
                    public void run() {
                        if (tracker != null) {
                            String deeplink = tracker.checkForDeferredDeeplink(timeout);
                            callbackContext.success(deeplink);
                        }
                    }
                });
                return true;
            } else if (GETMATID.equals(action)) {
                String matId = tracker.getMatId();
                callbackContext.success(matId);
                return true;
            } else if (GETOPENLOGID.equals(action)) {
                String logId = tracker.getOpenLogId();
                callbackContext.success(logId);
                return true;
            } else if (GETISPAYINGUSER.equals(action)) {
                boolean payingUser = tracker.getIsPayingUser();
                callbackContext.success(String.valueOf(payingUser));
                return true;
            } else if (SETDELEGATE.equals(action)) {
                // default to true
                boolean enabled = args.optBoolean(0, true);
                tracker.setMATResponse(new MATResponse() {
                    @Override
                    public void enqueuedActionWithRefId(String refId) {
                        PluginResult result = new PluginResult(PluginResult.Status.OK, "MATPlugin.matDelegate.enqueued: " + refId);
                        result.setKeepCallback(true);
                        callbackContext.sendPluginResult(result);
                    }

                    @Override
                    public void didSucceedWithData(JSONObject data) {
                        PluginResult result = new PluginResult(PluginResult.Status.OK, data.toString());
                        result.setKeepCallback(true);
                        callbackContext.sendPluginResult(result);
                    }

                    @Override
                    public void didFailWithError(JSONObject error) {
                        PluginResult result = new PluginResult(PluginResult.Status.OK, error.toString());
                        result.setKeepCallback(true);
                        callbackContext.sendPluginResult(result);
                    }
                });
                return true;
            } else {
                callbackContext.error("Unsupported action on Android");
                return false;
            }
        } catch (JSONException e) {
            callbackContext.error("JSON exception");
            return false;
        }
    }
    
    class InitThread implements Runnable {
        Context context;
        String advertiserId;
        String advertiserKey;
        CallbackContext cbc;
        
        public InitThread(Context context, String id, String key, CallbackContext callbackContext) {
            this.context = context;
            this.advertiserId = id;
            this.advertiserKey = key;
            this.cbc = callbackContext;
        }
        
        @Override
        public void run() {
            MobileAppTracker.init(context, advertiserId, advertiserKey);
            tracker = MobileAppTracker.getInstance();
            tracker.setPluginName("phonegap");
            try {
                Activity act = (Activity) context;
                tracker.setReferralSources(act);
            } catch (Exception e) {
            }
            cbc.success();
        }
    }
    
    class MeasureActionThread implements Runnable {
        String eventName;
        double revenue;
        String currency;
        String refId;
        List<MATEventItem> eventItemList;
        String receiptData;
        String receiptSignature;
        CallbackContext cbc;
        
        public MeasureActionThread(String eventName, double revenue, String currency, String refId, List<MATEventItem> eventItemList, String receiptData, String receiptSignature, CallbackContext callbackContext) {
            this.eventName = eventName;
            this.revenue = revenue;
            this.currency = currency;
            this.refId = refId;
            this.eventItemList = eventItemList;
            this.receiptData = receiptData;
            this.receiptSignature = receiptSignature;
            this.cbc = callbackContext;
        }
        
        @Override
        public void run() {
            if (tracker != null) {
                // If there are any event items, track with event item
                if (eventItemList != null && eventItemList.size() > 0) {
                    if (receiptData != null && !receiptData.equals("null") && receiptSignature != null && !receiptSignature.equals("null")) {
                        // Track with receipt data if not null
                        tracker.measureAction(eventName, eventItemList, revenue, currency, refId, receiptData, receiptSignature);
                    } else {
                        // Track with just event item
                        tracker.measureAction(eventName, eventItemList, revenue, currency, refId);
                    }
                } else if (receiptData != null && receiptSignature != null) {
                    tracker.measureAction(eventName, null, revenue, currency, refId, receiptData, receiptSignature);
                } else if (refId != null && refId.length() > 0) {
                    tracker.measureAction(eventName, revenue, currency, refId);
                } else {
                    tracker.measureAction(eventName, revenue, currency);
                }
                cbc.success();
            } else {
                cbc.error("Tracker was null");
            }
        }
    }
}
