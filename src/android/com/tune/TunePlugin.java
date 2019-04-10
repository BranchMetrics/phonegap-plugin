package com.tune;

import java.lang.Double;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.provider.Settings.Secure;
import android.telephony.TelephonyManager;
import android.text.TextUtils;
import android.util.Log;

import com.tune.Tune;
import com.tune.TuneDeeplinkListener;
import com.tune.TuneEvent;
import com.tune.TuneEventItem;
import com.tune.TunePreloadData;
import com.tune.TuneInternal;

public class TunePlugin extends CordovaPlugin {
    private static final String TAG = "TunePlugin::";

    public static final String INITTUNE = "initTune";

    public static final String GETADVERTISINGID = "getAdvertisingId";
    public static final String GETISPAYINGUSER = "getIsPayingUser";
    public static final String GETISPRIVACYPROTECTEDDUETOAGE = "getIsPrivacyProtectedDueToAge";
    public static final String GETOPENLOGID = "getOpenLogId";
    public static final String GETTUNEID = "getTuneId";
    public static final String MEASUREEVENT = "measureEvent";
    public static final String MEASUREEVENTNAME = "measureEventName";
    public static final String MEASURESESSION = "measureSession";
    public static final String REGISTERDEEPLINKLISTENER = "registerDeeplinkListener";
    public static final String SETAPPADMEASUREMENT = "setAppAdTrackingEnabled";
    public static final String SETDEBUG = "setDebugMode";
    public static final String SETDEEPLINK = "setDeepLink";
    public static final String SETDEVICEID = "setDeviceId";
    public static final String SETEXISTINGUSER = "setExistingUser";
    public static final String SETFBEVENTLOGGING = "setFacebookEventLogging";
    public static final String SETGOOGLEADVERTISINGID = "setGoogleAdvertisingId";
    public static final String SETPAYINGUSER = "setPayingUser";
    public static final String SETPRELOADDATA = "setPreloadData";
    public static final String SETPRIVACYPROTECTEDDUETOAGE = "setPrivacyProtectedDueToAge";
    public static final String SETUSERID = "setUserId";
    public static final String UNREGISTERDEEPLINKLISTENER = "unregisterDeeplinkListener";

    public static final String ISTUNELINK = "isTuneLink";
    public static final String REGISTERCUSTOMTUNELINKDOMAIN = "registerCustomTuneLinkDomain";

    private ITune tune;

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        if (tune == null && Tune.getInstance() != null) {
            Log.w(TAG, "re-acquiring Tune instance");
            tune = Tune.getInstance();
        }

        if (INITTUNE.equals(action)) {
            if (tune == null) {
                Log.d(TAG, "INITTUNE()");

                String advertiserId = args.optString(0);
                String advertiserKey = args.optString(1);
                String packageName = args.optString(2);

                if (advertiserId.length() > 0 && advertiserKey.length() > 0) {
                    tune = Tune.init(cordova.getActivity().getApplicationContext(), advertiserId, advertiserKey, packageName);
                    // TODO: access tuneInternal
                    //tune.setPluginName("phonegap");

                    callbackContext.success();
                } else {
                    callbackContext.error("TUNE advertiser ID or key is empty");
                }
            } else {
                Log.d(TAG, "INITTUNE() -- already initialized!");
            }
            return true;

        } else if (tune == null) {
            callbackContext.error("TUNE is not initialzed");
            return true;

        } else if (MEASURESESSION.equals(action)) {
            // TODO: access tuneInternal
            //tune.measureSessionInternal();
            callbackContext.success();
            return true;
        } else if (MEASUREEVENTNAME.equals(action)) {
            String eventName = args.optString(0);
            if (eventName.length() > 0) {
                tune.measureEvent(eventName);
                callbackContext.success();
            } else {
                callbackContext.error("Event name is empty");
            }
            return true;
        } else if (MEASUREEVENT.equals(action)) {
            // Parse TuneEvent from first arg
            JSONObject tuneEvent = args.optJSONObject(0);
            if (tuneEvent != null) {
                String eventName        = tuneEvent.optString("name");
                double revenue          = tuneEvent.optDouble("revenue");
                String currencyCode     = tuneEvent.optString("currency");
                String refId            = tuneEvent.optString("advertiserRefId");
                JSONArray eventItems    = tuneEvent.optJSONArray("eventItems");
                String receiptData      = tuneEvent.optString("receipt");
                String receiptSignature = tuneEvent.optString("receiptSignature");
                String contentType      = tuneEvent.optString("contentType");
                String contentId        = tuneEvent.optString("contentId");
                int level               = tuneEvent.optInt("level");
                int quantity            = tuneEvent.optInt("quantity");
                String searchString     = tuneEvent.optString("searchString");
                double rating           = tuneEvent.optDouble("rating");
                double date1            = tuneEvent.optDouble("date1");
                double date2            = tuneEvent.optDouble("date2");
                String attribute1       = tuneEvent.optString("attribute1");
                String attribute2       = tuneEvent.optString("attribute2");
                String attribute3       = tuneEvent.optString("attribute3");
                String attribute4       = tuneEvent.optString("attribute4");
                String attribute5       = tuneEvent.optString("attribute5");

                if (!eventName.isEmpty()) {
                    // Create TuneEvent from JSONObject fields
                    TuneEvent event = new TuneEvent(eventName);
                    if (!Double.isNaN(revenue)) {
                        event.withRevenue(revenue);
                    }
                    event.withCurrencyCode(currencyCode);
                    event.withAdvertiserRefId(refId);
                    if (eventItems != null) {
                        // Convert JSONArray of JSONObjects into List of TuneEventItems
                        List<TuneEventItem> eventItemList = new ArrayList<TuneEventItem>();
                        for (int i = 0; i < eventItems.length(); i++) {
                            JSONObject item = eventItems.optJSONObject(i);
                            if (!item.has("item")) {
                                // If event item missing item name, go to next item
                                continue;
                            }
                            String name = item.optString("item");
                            int itemQuantity = item.optInt("quantity");
                            double unitPrice = item.optDouble("unit_price", 0);
                            double itemRevenue = item.optDouble("revenue", 0);
                            String attribute_sub1 = item.optString("attribute_sub1");
                            String attribute_sub2 = item.optString("attribute_sub2");
                            String attribute_sub3 = item.optString("attribute_sub3");
                            String attribute_sub4 = item.optString("attribute_sub4");
                            String attribute_sub5 = item.optString("attribute_sub5");

                            TuneEventItem eventItem = new TuneEventItem(name)
                                                         .withQuantity(itemQuantity)
                                                         .withUnitPrice(unitPrice)
                                                         .withRevenue(itemRevenue)
                                                         .withAttribute1(attribute_sub1)
                                                         .withAttribute2(attribute_sub2)
                                                         .withAttribute3(attribute_sub3)
                                                         .withAttribute4(attribute_sub4)
                                                         .withAttribute5(attribute_sub5);
                            eventItemList.add(eventItem);
                        }
                        event.withEventItems(eventItemList);
                    }
                    event.withReceipt(receiptData, receiptSignature);
                    event.withContentType(contentType);
                    event.withContentId(contentId);
                    if (level != 0) {
                        event.withLevel(level);
                    }
                    if (quantity != 0) {
                        event.withQuantity(quantity);
                    }
                    event.withSearchString(searchString);
                    if (!Double.isNaN(rating)) {
                        event.withRating(rating);
                    }
                    if (!Double.isNaN(date1)) {
                        event.withDate1(new Date((long)date1));
                    }
                    if (!Double.isNaN(date2)) {
                        event.withDate2(new Date((long)date2));
                    }
                    event.withAttribute1(attribute1);
                    event.withAttribute2(attribute2);
                    event.withAttribute3(attribute3);
                    event.withAttribute4(attribute4);
                    event.withAttribute5(attribute5);

                    // Call measureEvent with constructed TuneEvent
                    tune.measureEvent(event);
                    callbackContext.success();
                } else {
                    callbackContext.error("Event name is empty");
                }
            }
            return true;
        } else if (SETAPPADMEASUREMENT.equals(action)) {
            boolean adTracking = args.optBoolean(0);
            tune.setAppAdTrackingEnabled(adTracking);
            callbackContext.success();
            return true;
        } else if (SETDEBUG.equals(action)) {
            boolean debug = args.optBoolean(0);
            Tune.setDebugMode(debug);
            callbackContext.success();
            return true;
        } else if (SETEXISTINGUSER.equals(action)) {
            boolean existingUser = args.optBoolean(0);
            tune.setExistingUser(existingUser);
            callbackContext.success();
            return true;
        } else if (SETFBEVENTLOGGING.equals(action)) {
            boolean fbEventLogging = args.optBoolean(0);
            boolean limitEventAndDataUsage = args.optBoolean(1);
            tune.setFacebookEventLogging(fbEventLogging, limitEventAndDataUsage);
            callbackContext.success();
            return true;
        } else if (SETPAYINGUSER.equals(action)) {
            boolean payingUser = args.optBoolean(0);
            tune.setPayingUser(payingUser);
            callbackContext.success();
            return true;
        } else if (SETPRIVACYPROTECTEDDUETOAGE.equals(action)) {
            boolean privacyProtected = args.optBoolean(0);
            tune.setPrivacyProtectedDueToAge(privacyProtected);
            callbackContext.success();
            return true;
        } else if (SETUSERID.equals(action)) {
            String userId = args.optString(0);
            if (!userId.isEmpty()) {
                tune.setUserId(userId);
            }
            callbackContext.success();
            return true;
        } else if (SETPRELOADDATA.equals(action)) {
            // Parse preload data from first arg
            JSONObject preloadData = args.optJSONObject(0);
            if (preloadData != null) {
                String publisherId              = preloadData.optString("publisherId");
                String offerId                  = preloadData.optString("offerId");
                String agencyId                 = preloadData.optString("agencyId");
                String publisherReferenceId     = preloadData.optString("publisherReferenceId");
                String publisherSub1            = preloadData.optString("publisherSub1");
                String publisherSub2            = preloadData.optString("publisherSub2");
                String publisherSub3            = preloadData.optString("publisherSub3");
                String publisherSub4            = preloadData.optString("publisherSub4");
                String publisherSub5            = preloadData.optString("publisherSub5");
                String publisherSubAd           = preloadData.optString("publisherSubAd");
                String publisherSubAdgroup      = preloadData.optString("publisherSubAdgroup");
                String publisherSubCampaign     = preloadData.optString("publisherSubCampaign");
                String publisherSubKeyword      = preloadData.optString("publisherSubKeyword");
                String publisherSubPublisher    = preloadData.optString("publisherSubPublisher");
                String publisherSubSite         = preloadData.optString("publisherSubSite");
                String advertiserSubAd          = preloadData.optString("advertiserSubAd");
                String advertiserSubAdgroup     = preloadData.optString("advertiserSubAdgroup");
                String advertiserSubCampaign    = preloadData.optString("advertiserSubCampaign");
                String advertiserSubKeyword     = preloadData.optString("advertiserSubKeyword");
                String advertiserSubPublisher   = preloadData.optString("advertiserSubPublisher");
                String advertiserSubSite        = preloadData.optString("advertiserSubSite");

                if (!publisherId.isEmpty()) {
                    // Create TunePreloadData from JSONObject fields
                    TunePreloadData tunePreloadData = new TunePreloadData(publisherId)
                                                        .withOfferId(offerId)
                                                        .withAgencyId(agencyId)
                                                        .withPublisherReferenceId(publisherReferenceId)
                                                        .withPublisherSub1(publisherSub1)
                                                        .withPublisherSub2(publisherSub2)
                                                        .withPublisherSub3(publisherSub3)
                                                        .withPublisherSub4(publisherSub4)
                                                        .withPublisherSub5(publisherSub5)
                                                        .withPublisherSubAd(publisherSubAd)
                                                        .withPublisherSubAdgroup(publisherSubAdgroup)
                                                        .withPublisherSubCampaign(publisherSubCampaign)
                                                        .withPublisherSubKeyword(publisherSubKeyword)
                                                        .withPublisherSubPublisher(publisherSubPublisher)
                                                        .withPublisherSubSite(publisherSubSite)
                                                        .withAdvertiserSubAd(advertiserSubAd)
                                                        .withAdvertiserSubAdgroup(advertiserSubAdgroup)
                                                        .withAdvertiserSubCampaign(advertiserSubCampaign)
                                                        .withAdvertiserSubKeyword(advertiserSubKeyword)
                                                        .withAdvertiserSubPublisher(advertiserSubPublisher)
                                                        .withAdvertiserSubSite(advertiserSubSite);
                    tune.setPreloadedAppData(tunePreloadData);
                }
            }
            callbackContext.success();
            return true;
        } else if (GETTUNEID.equals(action)) {
            String tuneId = tune.getMatId();
            callbackContext.success(tuneId);
            return true;
        } else if (GETOPENLOGID.equals(action)) {
            String logId = tune.getOpenLogId();
            callbackContext.success(logId);
            return true;
        } else if (GETISPAYINGUSER.equals(action)) {
            boolean payingUser = tune.isPayingUser();
            callbackContext.success(String.valueOf(payingUser));
            return true;
        } else if (GETISPRIVACYPROTECTEDDUETOAGE.equals(action)) {
            boolean isProtected = tune.isPrivacyProtectedDueToAge();
            callbackContext.success(String.valueOf(isProtected));
            return true;
        } else if (REGISTERCUSTOMTUNELINKDOMAIN.equals(action)) {
            String domainSuffix = args.optString(0);
            tune.registerCustomTuneLinkDomain(domainSuffix);
            return true;

        } else if (REGISTERDEEPLINKLISTENER.equals(action)) {
            tune.registerDeeplinkListener(new TuneDeeplinkListener() {
                @Override
                public void didReceiveDeeplink(String deeplink) {
                    PluginResult result = new PluginResult(PluginResult.Status.OK, deeplink);
                    result.setKeepCallback(true);
                    callbackContext.sendPluginResult(result);
                }

                @Override
                public void didFailDeeplink(String error) {
                    PluginResult result = new PluginResult(PluginResult.Status.ERROR, error);
                    result.setKeepCallback(true);
                    callbackContext.sendPluginResult(result);
                }
            });
            return true;

        } else if (UNREGISTERDEEPLINKLISTENER.equals(action)) {
            tune.unregisterDeeplinkListener();
            return true;

        } else if (ISTUNELINK.equals(action)) {
            String appLinkUrl = args.optString(0);
            boolean isTuneLInk = tune.isTuneLink(appLinkUrl);
            callbackContext.success(String.valueOf(isTuneLInk));
            return true;

        } else {
            callbackContext.error("Unsupported action on Android");
        }

        return false;
    }
}
