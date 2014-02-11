package com.mobileapptracking;

import java.util.ArrayList;
import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.mobileapptracker.MATEventItem;
import com.mobileapptracker.MobileAppTracker;

public class MATPlugin extends CordovaPlugin {
    public static final String INIT = "initTracker";
    public static final String TRACKACTION = "trackAction";
    public static final String TRACKACTIONWITHITEMS = "trackActionWithItems";
    public static final String TRACKACTIONWITHRECEIPT = "trackActionWithReceipt";
    public static final String TRACKSESSION = "trackSession";
    public static final String SETAGE = "setAge";
    public static final String SETAPPADTRACKING = "setAppAdTracking";
    public static final String SETALLOWDUP = "setAllowDuplicates";
    public static final String SETDEBUG = "setDebugMode";
    public static final String SETEVENTATTRIBUTE1 = "setEventAttribute1";
    public static final String SETEVENTATTRIBUTE2 = "setEventAttribute2";
    public static final String SETEVENTATTRIBUTE3 = "setEventAttribute3";
    public static final String SETEVENTATTRIBUTE4 = "setEventAttribute4";
    public static final String SETEVENTATTRIBUTE5 = "setEventAttribute5";
    public static final String SETEXISTINGUSER = "setExistingUser";
    public static final String SETGENDER = "setGender";
    public static final String SETGOOGLEADVERTISINGID = "setGoogleAdvertisingId";
    public static final String SETLOCATION = "setLocation";
    public static final String SETLOCATIONWITHALTITUDE = "setLocationWithAltitude";
    public static final String SETPACKAGENAME = "setPackageName";
    public static final String SETTRACKING = "setTracking";
    public static final String SETTPID = "setTRUSTeID";
    public static final String SETUSEREMAIL = "setUserEmail";
    public static final String SETUSERID = "setUserId";
    public static final String SETUSERNAME = "setUserName";
    public static final String SETFBUSERID = "setFacebookUserId";
    public static final String SETTWUSERID = "setTwitterUserId";
    public static final String SETGGUSERID = "setGoogleUserId";
    
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
            } else if (TRACKSESSION.equals(action)) {
                cordova.getThreadPool().execute(new Runnable() {
                    public void run() {
                        if (tracker != null) {
                            tracker.trackSession();
                        }
                        callbackContext.success();
                    }
                });
                return true;
            } else if (TRACKACTION.equals(action)) {
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
                    cordova.getThreadPool().execute(new TrackActionThread(eventName, revenue, currency, refId, null, null, null, callbackContext));
                    return true;
                } else {
                    callbackContext.error("Event name null or empty");
                    return false;
                }
            } else if (TRACKACTIONWITHITEMS.equals(action) || TRACKACTIONWITHRECEIPT.equals(action)) {
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
                    cordova.getThreadPool().execute(new TrackActionThread(eventName, revenue, currency, refId, eventItemList, receiptData, receiptSignature, callbackContext));
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
            } else if (SETAPPADTRACKING.equals(action)) {
                boolean adTracking = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setLimitAdTrackingEnabled(!adTracking);
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
            } else if (SETEXISTINGUSER.equals(action)) {
                boolean existingUser = args.getBoolean(0);
                if (tracker != null) {
                    tracker.setExistingUser(existingUser);
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
                if (tracker != null) {
                    tracker.setGoogleAdvertisingId(googleAid);
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
            } else if (SETTRACKING.equals(action)) {
                String targetPackageName = args.getString(0);
                String publisherAdvertiserId = args.getString(1);
                String targetOfferId = args.getString(2);
                String targetPublisherId = args.getString(3);
                boolean shouldRedirect = args.getBoolean(4);
                
                if (tracker != null) {
                    tracker.setTracking(publisherAdvertiserId, targetPackageName, targetPublisherId, targetOfferId, shouldRedirect);
                }
                callbackContext.success();
                return true;
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
            tracker.setReferralSources(context);
            cbc.success();
        }
    }
    
    class TrackActionThread implements Runnable {
        String eventName;
        double revenue;
        String currency;
        String refId;
        List<MATEventItem> eventItemList;
        String receiptData;
        String receiptSignature;
        CallbackContext cbc;
        
        public TrackActionThread(String eventName, double revenue, String currency, String refId, List<MATEventItem> eventItemList, String receiptData, String receiptSignature, CallbackContext callbackContext) {
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
            // Set currency code if exists
            if (currency != null && currency.length() > 0 && !currency.equals("null")) {
                tracker.setCurrencyCode(currency);
            }
            // If there are any event items, track with event item
            if (eventItemList != null && eventItemList.size() > 0) {
                if (receiptData != null && !receiptData.equals("null") && receiptSignature != null && !receiptSignature.equals("null")) {
                    // Track with receipt data if not null
                    tracker.trackAction(eventName, eventItemList, revenue, tracker.getCurrencyCode(), refId, receiptData, receiptSignature);
                } else {
                    // Track with just event item
                    tracker.trackAction(eventName, eventItemList, revenue, tracker.getCurrencyCode(), refId);
                }
            } else if (receiptData != null && receiptSignature != null) {
                tracker.trackAction(eventName, revenue, tracker.getCurrencyCode(), refId, receiptData, receiptSignature);
            } else if (refId != null && refId.length() > 0) {
                tracker.trackAction(eventName, revenue, tracker.getCurrencyCode(), refId);
            } else if (currency != null && currency.length() > 0) {
                tracker.trackAction(eventName, revenue, tracker.getCurrencyCode());
            } else {
                tracker.trackAction(eventName, revenue);
            }
            cbc.success();
        }
    }
}
