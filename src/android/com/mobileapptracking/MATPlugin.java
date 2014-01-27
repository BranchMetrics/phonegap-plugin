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
    public static final String TRACKINSTALL = "trackInstall";
    public static final String TRACKACTION = "trackAction";
    public static final String TRACKACTIONWITHITEMS = "trackActionWithItems";
    public static final String TRACKACTIONWITHRECEIPT = "trackActionWithReceipt";
    public static final String TRACKUPDATE = "trackUpdate";
    public static final String SETAGE = "setAge";
    public static final String SETAPPADTRACKING = "setAppAdTracking";
    public static final String SETALLOWDUP = "setAllowDuplicates";
    public static final String SETDEBUG = "setDebugMode";
    public static final String SETGENDER = "setGender";
    public static final String SETLOCATION = "setLocation";
    public static final String SETLOCATIONWITHALTITUDE = "setLocationWithAltitude";
    public static final String SETPACKAGENAME = "setPackageName";
    public static final String SETREFID = "setRefId";
    public static final String SETTPID = "setTrusteTPID";
    public static final String SETUSERID = "setUserId";
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
            } else if (TRACKINSTALL.equals(action)) {
                cordova.getThreadPool().execute(new Runnable() {
                    public void run() {
                        if (tracker != null) {
                            tracker.trackInstall();
                        }
                        callbackContext.success();
                    }
                });
                return true;
            } else if (TRACKUPDATE.equals(action)) {
                cordova.getThreadPool().execute(new Runnable() {
                    public void run() {
                        if (tracker != null) {
                            tracker.trackUpdate();
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
                    refId = args.getString(2);
                    revenue = args.getDouble(3);
                    currency = args.getString(4);
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
                    eventItems = args.getJSONArray(2);
                    refId = args.getString(3);
                    revenue = args.getDouble(4);
                    currency = args.getString(5);
                    receiptData = args.getString(7);
                    receiptSignature = args.getString(8);
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
            } else if (SETGENDER.equals(action)) {
                int gender = args.getInt(0);
                if (tracker != null) {
                    tracker.setGender(gender);
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
            } else if (SETREFID.equals(action)) {
                String refId = args.getString(0);
                if (refId != null && refId.length() > 0) {
                    if (tracker != null) {
                        tracker.setRefId(refId);
                    }
                    callbackContext.success();
                    return true;
                } else {
                    callbackContext.error("Ref ID null or empty");
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
            tracker = new MobileAppTracker(context, advertiserId, advertiserKey);
            tracker.setPluginName("phonegap");
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
            // If there are any event items, track with event item
            if (eventItemList != null && eventItemList.size() > 0) {
                // Set revenue if exists
                if (revenue != 0) {
                    tracker.setRevenue(revenue);
                }
                // Set currency code if exists
                if (currency != null && currency.length() > 0 && !currency.equals("null")) {
                    tracker.setCurrencyCode(currency);
                }
                // Set advertiser ref ID if exists
                if (refId != null && refId.length() > 0 && !refId.equals("null")) {
                    tracker.setRefId(refId);
                }
                if (receiptData != null && !receiptData.equals("null") && receiptSignature != null && !receiptSignature.equals("null")) {
                    // Track with receipt data if not null
                    tracker.trackAction(eventName, eventItemList, receiptData, receiptSignature);
                } else {
                    // Track with just event item
                    tracker.trackAction(eventName, eventItemList);
                }
            } else if (receiptData != null && receiptSignature != null) {
                tracker.trackAction(eventName, revenue, currency, refId, receiptData, receiptSignature);
            } else if (refId != null && refId.length() > 0) {
                tracker.trackAction(eventName, revenue, currency, refId);
            } else if (currency != null && currency.length() > 0) {
                tracker.trackAction(eventName, revenue, currency);
            } else {
                tracker.trackAction(eventName, revenue);
            }
            cbc.success();
        }
    }
}
