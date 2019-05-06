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

    private static final String INIT_TUNE = "initTune";
    private static final String GET_IS_PAYING_USER = "getIsPayingUser";
    private static final String GET_IS_PRIVACY_PROTECTED_DUE_TO_AGE = "getIsPrivacyProtectedDueToAge";
    private static final String GET_OPEN_LOG_ID = "getOpenLogId";
    private static final String GET_TUNE_ID = "getTuneId";
    private static final String MEASURE_EVENT = "measureEvent";
    private static final String MEASURE_EVENT_NAME = "measureEventName";
    private static final String MEASURE_SESSION = "measureSession";
    private static final String REGISTER_DEEPLINK_LISTENER = "registerDeeplinkListener";
    private static final String SET_APP_AD_MEASUREMENT = "setAppAdTrackingEnabled";
    private static final String SET_DEBUG = "setDebugMode";
    private static final String SET_DEEPLINK = "setDeepLink";
    private static final String SET_EXISTING_USER = "setExistingUser";
    private static final String SET_FB_EVENT_LOGGING = "setFacebookEventLogging";
    private static final String SET_PAYING_USER = "setPayingUser";
    private static final String SET_PRELOAD_DATA = "setPreloadData";
    private static final String SET_PRIVACY_PROTECTED_DUE_TO_AGE = "setPrivacyProtectedDueToAge";
    private static final String SET_USER_ID = "setUserId";
    private static final String UNREGISTER_DEEPLINK_LISTENER = "unregisterDeeplinkListener";
    private static final String IS_TUNE_LINK = "isTuneLink";
    private static final String REGISTER_CUSTOM_TUNE_LINK_DOMAIN = "registerCustomTuneLinkDomain";

    // methods only available on iOS
    private static final String GET_ADVERTISING_ID = "getAdvertisingId"; // There is no Tune API to retrieve the GAID
    private static final String AUTOMATE_IN_APP_PURCHASE_EVENT_AUTOMATION = "automateInAppPurchaseEventMeasurement";
    private static final String SET_JAILBROKEN = "setJailbroken";

    private ITune tune;

    private boolean initTune(JSONArray args, final CallbackContext callbackContext) {
        if (tune == null) {
            Log.d(TAG, "initTune()");

            String advertiserId = args.optString(0);
            String advertiserKey = args.optString(1);
            String packageName = args.optString(2);

            if (advertiserId.length() > 0 && advertiserKey.length() > 0) {
                tune = Tune.init(cordova.getActivity().getApplicationContext(), advertiserId, advertiserKey, packageName);
                TuneInternal tuneInternal = (TuneInternal)tune;
                tuneInternal.setPluginName("phonegap");

                callbackContext.success();
            } else {
                callbackContext.error("TUNE advertiser ID or key is empty");
            }
        } else {
            Log.d(TAG, "initTune() -- already initialized!");
        }
        return true;
    }

    private boolean measureSession(JSONArray args, final CallbackContext callbackContext) {
        TuneInternal tuneInternal = (TuneInternal)tune;
        tuneInternal.measureSessionInternal();
        callbackContext.success();
        return true;
    }

    private boolean measureEventName(JSONArray args, final CallbackContext callbackContext) {
        String eventName = args.optString(0);
        if (eventName.length() > 0) {
            tune.measureEvent(eventName);
            callbackContext.success();
        } else {
            callbackContext.error("Event name is empty");
        }
        return true;
    }

    private boolean measureEvent(JSONArray args, final CallbackContext callbackContext) {
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
    }

    private boolean setAppAdMeasurement(JSONArray args, final CallbackContext callbackContext) {
        boolean adTracking = args.optBoolean(0);
        tune.setAppAdTrackingEnabled(adTracking);
        callbackContext.success();
        return true;
    }
    
    private boolean setDebug(JSONArray args, final CallbackContext callbackContext) {
        boolean debug = args.optBoolean(0);
        Tune.setDebugMode(debug);
        callbackContext.success();
        return true;
    }

    private boolean setExistingUser(JSONArray args, final CallbackContext callbackContext) {
        boolean existingUser = args.optBoolean(0);
        tune.setExistingUser(existingUser);
        callbackContext.success();
        return true;
    }

    private boolean setFacebookEventLogging(JSONArray args, final CallbackContext callbackContext) {
        boolean fbEventLogging = args.optBoolean(0);
        boolean limitEventAndDataUsage = args.optBoolean(1);
        tune.setFacebookEventLogging(fbEventLogging, limitEventAndDataUsage);
        callbackContext.success();
        return true;
    }

    private boolean setPayingUser(JSONArray args, final CallbackContext callbackContext) {
        boolean payingUser = args.optBoolean(0);
        tune.setPayingUser(payingUser);
        callbackContext.success();
        return true;
    }

    private boolean setPrivacyProtectedDueToAge(JSONArray args, final CallbackContext callbackContext) {
        boolean privacyProtected = args.optBoolean(0);
        tune.setPrivacyProtectedDueToAge(privacyProtected);
        callbackContext.success();
        return true;
    }

    private boolean setUserId(JSONArray args, final CallbackContext callbackContext) {
        String userId = args.optString(0);
        if (!userId.isEmpty()) {
            tune.setUserId(userId);
        }
        callbackContext.success();
        return true;
    }

    private boolean setPreloadedAppData(JSONArray args, final CallbackContext callbackContext) {
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
    }

    private boolean getTuneId(JSONArray args, final CallbackContext callbackContext) {
        String tuneId = tune.getMatId();
        callbackContext.success(tuneId);
        return true;
    }

    private boolean getOpenLogId(JSONArray args, final CallbackContext callbackContext) {
        String logId = tune.getOpenLogId();
        callbackContext.success(logId);
        return true;
    }

    private boolean isPayingUser(JSONArray args, final CallbackContext callbackContext) {
        boolean payingUser = tune.isPayingUser();
        callbackContext.success(String.valueOf(payingUser));
        return true;
    }

    private boolean isPrivacyProtectedDueToAge(JSONArray args, final CallbackContext callbackContext) {
        boolean isProtected = tune.isPrivacyProtectedDueToAge();
        callbackContext.success(String.valueOf(isProtected));
        return true;
    }

    private boolean registerCustomTuneLinkDomain(JSONArray args, final CallbackContext callbackContext) {
        String domainSuffix = args.optString(0);
        tune.registerCustomTuneLinkDomain(domainSuffix);
        return true;
    }

    private boolean registerDeeplinkListener(JSONArray args, final CallbackContext callbackContext) {
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
    }

    private boolean unregisterDeeplinkListener(JSONArray args, final CallbackContext callbackContext) {
        tune.unregisterDeeplinkListener();
        return true;
    }

    private boolean isTuneLink(JSONArray args, final CallbackContext callbackContext) {
        String appLinkUrl = args.optString(0);
        boolean isTuneLInk = tune.isTuneLink(appLinkUrl);
        callbackContext.success(String.valueOf(isTuneLInk));
        return true;
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        if (tune == null && Tune.getInstance() != null) {
            tune = Tune.getInstance();
        }

        if (INIT_TUNE.equals(action)) {
            return initTune(args, callbackContext);

        } else if (tune == null) {
            callbackContext.error("TUNE is not initialzed");
            return true;

        } else if (MEASURE_SESSION.equals(action)) {
            return measureSession(args, callbackContext);

        } else if (MEASURE_EVENT_NAME.equals(action)) {
            return measureEventName(args, callbackContext);

        } else if (MEASURE_EVENT.equals(action)) {
            return measureEvent(args, callbackContext);

        } else if (SET_APP_AD_MEASUREMENT.equals(action)) {
            return setAppAdMeasurement(args, callbackContext);

        } else if (SET_DEBUG.equals(action)) {
            return setDebug(args, callbackContext);

        } else if (SET_EXISTING_USER.equals(action)) {
            return setExistingUser(args, callbackContext);

        } else if (SET_FB_EVENT_LOGGING.equals(action)) {
            return setFacebookEventLogging(args, callbackContext);

        } else if (SET_PAYING_USER.equals(action)) {
            return setPayingUser(args, callbackContext);

        } else if (SET_PRIVACY_PROTECTED_DUE_TO_AGE.equals(action)) {
            return setPrivacyProtectedDueToAge(args, callbackContext);

        } else if (SET_USER_ID.equals(action)) {
            return setUserId(args, callbackContext);

        } else if (SET_PRELOAD_DATA.equals(action)) {
            return setPreloadedAppData(args, callbackContext);

        } else if (GET_TUNE_ID.equals(action)) {
            return getTuneId(args, callbackContext);

        } else if (GET_OPEN_LOG_ID.equals(action)) {
            return getOpenLogId(args, callbackContext);

        } else if (GET_IS_PAYING_USER.equals(action)) {
            return isPayingUser(args, callbackContext);

        } else if (GET_IS_PRIVACY_PROTECTED_DUE_TO_AGE.equals(action)) {
            return isPrivacyProtectedDueToAge(args, callbackContext);

        } else if (REGISTER_CUSTOM_TUNE_LINK_DOMAIN.equals(action)) {
            return registerCustomTuneLinkDomain(args, callbackContext);

        } else if (REGISTER_DEEPLINK_LISTENER.equals(action)) {
            return registerDeeplinkListener(args, callbackContext);

        } else if (UNREGISTER_DEEPLINK_LISTENER.equals(action)) {
            return unregisterDeeplinkListener(args, callbackContext);

        } else if (IS_TUNE_LINK.equals(action)) {
            return isTuneLink(args, callbackContext);

        } else if (GET_ADVERTISING_ID.equals(action) || AUTOMATE_IN_APP_PURCHASE_EVENT_AUTOMATION.equals(action) || SET_JAILBROKEN.equals(action)) {
            // noop iOS methods
            return true;
        }

        return false;
    }
}
