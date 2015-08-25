package com.mobileapptracking;

import java.lang.Double;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
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
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import com.mobileapptracker.MobileAppTracker;
import com.mobileapptracker.MATDeeplinkListener;
import com.mobileapptracker.MATEvent;
import com.mobileapptracker.MATEventItem;
import com.mobileapptracker.MATGender;
import com.mobileapptracker.MATPreloadData;
import com.mobileapptracker.MATResponse;
import com.mobileapptracker.MATUtils;
import com.tune.crosspromo.TuneAd;
import com.tune.crosspromo.TuneAdListener;
import com.tune.crosspromo.TuneAdMetadata;
import com.tune.crosspromo.TuneBanner;
import com.tune.crosspromo.TuneBannerPosition;
import com.tune.crosspromo.TuneInterstitial;

public class MATPlugin extends CordovaPlugin {
    public static final String INIT = "init";
    public static final String MEASUREEVENT = "measureEvent";
    public static final String MEASUREEVENTNAME = "measureEventName";
    public static final String MEASUREEVENTID = "measureEventId";
    public static final String MEASURESESSION = "measureSession";
    public static final String CHECKFORDEFERREDDEEPLINK = "checkForDeferredDeeplink";
    public static final String SETAGE = "setAge";
    public static final String SETANDROIDID = "setAndroidId";
    public static final String SETANDROIDIDMD5 = "setAndroidIdMd5";
    public static final String SETANDROIDIDSHA1 = "setAndroidIdSha1";
    public static final String SETANDROIDIDSHA256 = "setAndroidIdSha256";
    public static final String SETAPPADMEASUREMENT = "setAppAdMeasurement";
    public static final String SETALLOWDUP = "setAllowDuplicates";
    public static final String SETDEBUG = "setDebugMode";
    public static final String SETDELEGATE = "setDelegate";
    public static final String SETDEVICEID = "setDeviceId";
    public static final String SETEMAILCOLLECTION = "setEmailCollection";
    public static final String SETEXISTINGUSER = "setExistingUser";
    public static final String SETFBEVENTLOGGING = "setFacebookEventLogging";
    public static final String SETGENDER = "setGender";
    public static final String SETGOOGLEADVERTISINGID = "setGoogleAdvertisingId";
    public static final String SETLOCATION = "setLocation";
    public static final String SETLOCATIONWITHALTITUDE = "setLocationWithAltitude";
    public static final String SETPACKAGENAME = "setPackageName";
    public static final String SETPAYINGUSER = "setPayingUser";
    public static final String SETPRELOADDATA = "setPreloadData";
    public static final String SETTPID = "setTRUSTeID";
    public static final String SETUSEREMAIL = "setUserEmail";
    public static final String SETUSERID = "setUserId";
    public static final String SETUSERNAME = "setUserName";
    public static final String SETFBUSERID = "setFacebookUserId";
    public static final String SETTWUSERID = "setTwitterUserId";
    public static final String SETGGUSERID = "setGoogleUserId";
    public static final String GETMATID = "getMatId";
    public static final String GETOPENLOGID = "getOpenLogId";
    public static final String GETISPAYINGUSER = "getIsPayingUser";

    public static final String SHOWBANNER = "showBanner";
    public static final String HIDEBANNER = "hideBanner";
    public static final String CACHEINTERSTITIAL = "cacheInterstitial";
    public static final String SHOWINTERSTITIAL = "showInterstitial";
    
    private MobileAppTracker mat;

    private TuneBanner banner;
    private TuneInterstitial interstitial;
    private RelativeLayout adViewLayout = null;
    
    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        if (INIT.equals(action)) {
            String advertiserId = args.optString(0);
            String advertiserKey = args.optString(1);
            if (advertiserId.length() > 0 && advertiserKey.length() > 0) {
                mat = MobileAppTracker.init(cordova.getActivity(), advertiserId, advertiserKey);
                mat.setPluginName("phonegap");
                mat.setReferralSources(cordova.getActivity());
                callbackContext.success();
            } else {
                callbackContext.error("TUNE advertiser ID or key is empty");
            }
            return true;
        } else if (MEASURESESSION.equals(action)) {
            if (mat != null) {
                mat.measureSession();
            }
            callbackContext.success();
            return true;
        } else if (MEASUREEVENTNAME.equals(action)) {
            String eventName = args.optString(0);
            if (eventName.length() > 0) {
                if (mat != null) {
                    mat.measureEvent(eventName);
                }
                callbackContext.success();
            } else {
                callbackContext.error("Event name is empty");
            }
            return true;
        } else if (MEASUREEVENTID.equals(action)) {
            int eventId = args.optInt(0);
            if (mat != null) {
                mat.measureEvent(eventId);
            }
            callbackContext.success();
            return true;
        } else if (MEASUREEVENT.equals(action)) {
            // Parse MATEvent from first arg
            JSONObject matEvent = args.optJSONObject(0);
            if (matEvent != null && mat != null) {
                String eventName        = matEvent.optString("name");
                double revenue          = matEvent.optDouble("revenue");
                String currencyCode     = matEvent.optString("currency");
                String refId            = matEvent.optString("advertiserRefId");
                JSONArray eventItems    = matEvent.optJSONArray("eventItems");
                String receiptData      = matEvent.optString("receipt");
                String receiptSignature = matEvent.optString("receiptSignature");
                String contentType      = matEvent.optString("contentType");
                String contentId        = matEvent.optString("contentId");
                int level               = matEvent.optInt("level");
                int quantity            = matEvent.optInt("quantity");
                String searchString     = matEvent.optString("searchString");
                double rating           = matEvent.optDouble("rating");
                double date1            = matEvent.optDouble("date1");
                double date2            = matEvent.optDouble("date2");
                String attribute1       = matEvent.optString("attribute1");
                String attribute2       = matEvent.optString("attribute2");
                String attribute3       = matEvent.optString("attribute3");
                String attribute4       = matEvent.optString("attribute4");
                String attribute5       = matEvent.optString("attribute5");

                if (!eventName.isEmpty()) {
                    // Create MATEvent from JSONObject fields
                    MATEvent event = new MATEvent(eventName);
                    if (!Double.isNaN(revenue)) {
                        event.withRevenue(revenue);
                    }
                    event.withCurrencyCode(currencyCode);
                    event.withAdvertiserRefId(refId);
                    if (eventItems != null) {
                        // Convert JSONArray of JSONObjects into List of MATEventItems
                        List<MATEventItem> eventItemList = new ArrayList<MATEventItem>();
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
                            
                            MATEventItem eventItem = new MATEventItem(name)
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

                    // Call measureEvent with constructed MATEvent
                    mat.measureEvent(event);
                    callbackContext.success();
                } else {
                    callbackContext.error("Event name is empty");
                }
            }
            return true;
        } else if (CHECKFORDEFERREDDEEPLINK.equals(action)) {
            if (mat != null) {
                mat.checkForDeferredDeeplink(new MATDeeplinkListener() {
                    @Override
                    public void didReceiveDeeplink(String deeplink) {
                        PluginResult result = new PluginResult(PluginResult.Status.OK, deeplink);
                        callbackContext.sendPluginResult(result);
                    }

                    @Override
                    public void didFailDeeplink(String error) {
                        PluginResult result = new PluginResult(PluginResult.Status.ERROR, error);
                        callbackContext.sendPluginResult(result);
                    }
                });
            }
            return true;
        } else if (SETAGE.equals(action)) {
            int age = args.optInt(0);
            if (mat != null && age != 0) {
                mat.setAge(age);
            }
            callbackContext.success();
            return true;
        } else if (SETALLOWDUP.equals(action)) {
            boolean allowDups = args.optBoolean(0);
            if (mat != null) {
                mat.setAllowDuplicates(allowDups);
            }
            callbackContext.success();
            return true;
        } else if (SETANDROIDID.equals(action)) {
            boolean enableAndroidId = args.optBoolean(0);
            if (mat != null && enableAndroidId) {
                String androidId = Secure.getString(cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                mat.setAndroidId(androidId);
            }
            callbackContext.success();
            return true;
        } else if (SETANDROIDIDMD5.equals(action)) {
            boolean enableAndroidIdMd5 = args.optBoolean(0);
            if (mat != null && enableAndroidIdMd5) {
                String androidId = Secure.getString(cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                mat.setAndroidIdMd5(MATUtils.md5(androidId));
            }
            callbackContext.success();
            return true;
        } else if (SETANDROIDIDSHA1.equals(action)) {
            boolean enableAndroidIdSha1 = args.optBoolean(0);
            if (mat != null && enableAndroidIdSha1) {
                String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                mat.setAndroidIdSha1(MATUtils.sha1(androidId));
            }
            callbackContext.success();
            return true;
        } else if (SETANDROIDIDSHA256.equals(action)) {
            boolean enableAndroidIdSha256 = args.optBoolean(0);
            if (mat != null && enableAndroidIdSha256) {
                String androidId = Secure.getString(this.cordova.getActivity().getApplicationContext().getContentResolver(), Secure.ANDROID_ID);
                mat.setAndroidIdSha256(MATUtils.sha256(androidId));
            }
            callbackContext.success();
            return true;
        } else if (SETAPPADMEASUREMENT.equals(action)) {
            boolean adTracking = args.optBoolean(0);
            if (mat != null) {
                mat.setAppAdTrackingEnabled(adTracking);
            }
            callbackContext.success();
            return true;
        } else if (SETDEBUG.equals(action)) {
            boolean debug = args.optBoolean(0);
            if (mat != null) {
                mat.setDebugMode(debug);
            }
            callbackContext.success();
            return true;
        } else if (SETDEVICEID.equals(action)) {
            boolean enableDeviceId = args.optBoolean(0);
            if (mat != null && enableDeviceId) {
                // Check for READ_PHONE_STATE permission
                String permission = "android.permission.READ_PHONE_STATE";
                int res = this.cordova.getActivity().getApplicationContext().checkCallingOrSelfPermission(permission);
                if (res == PackageManager.PERMISSION_GRANTED) {
                    TelephonyManager telephonyManager = (TelephonyManager)this.cordova.getActivity().getApplicationContext().getSystemService(Context.TELEPHONY_SERVICE);
                    mat.setDeviceId(telephonyManager.getDeviceId());
                }
            }
            callbackContext.success();
            return true;
        } else if (SETEMAILCOLLECTION.equals(action)) {
            boolean collectEmail = args.optBoolean(0);
            if (mat != null && collectEmail) {
                mat.setEmailCollection(collectEmail);
            }
            callbackContext.success();
            return true;
        } else if (SETEXISTINGUSER.equals(action)) {
            boolean existingUser = args.optBoolean(0);
            if (mat != null) {
                mat.setExistingUser(existingUser);
            }
            callbackContext.success();
            return true;
        } else if (SETFBEVENTLOGGING.equals(action)) {
            boolean fbEventLogging = args.optBoolean(0);
            boolean limitEventAndDataUsage = args.optBoolean(1);
            if (mat != null) {
                mat.setFacebookEventLogging(fbEventLogging, cordova.getActivity(), limitEventAndDataUsage);
            }
            callbackContext.success();
            return true;
        } else if (SETGENDER.equals(action)) {
            try {
                int gender = args.getInt(0);
                if (mat != null) {
                    if (gender == 0) {
                        mat.setGender(MATGender.MALE);
                    } else if (gender == 1) {
                        mat.setGender(MATGender.FEMALE);
                    }
                }
                callbackContext.success();
            } catch (JSONException e) {
            }
            return true;
        } else if (SETGOOGLEADVERTISINGID.equals(action)) {
            String googleAid = args.optString(0);
            boolean isLAT = args.optBoolean(1);
            if (mat != null) {
                mat.setGoogleAdvertisingId(googleAid, isLAT);
            }
            callbackContext.success();
            return true;
        } else if (SETLOCATION.equals(action)) {
            double latitude = args.optDouble(0);
            double longitude = args.optDouble(1);
            if (mat != null && !Double.isNaN(latitude) && !Double.isNaN(longitude)) {
                mat.setLatitude(latitude);
                mat.setLongitude(longitude);
            }
            callbackContext.success();
            return true;
        } else if (SETLOCATIONWITHALTITUDE.equals(action)) {
            double latitude = args.optDouble(0);
            double longitude = args.optDouble(1);
            double altitude = args.optDouble(2);
            if (mat != null && !Double.isNaN(latitude) && !Double.isNaN(longitude) && !Double.isNaN(altitude)) {
                mat.setLatitude(latitude);
                mat.setLongitude(longitude);
                mat.setAltitude(altitude);
            }
            callbackContext.success();
            return true;
        } else if (SETPACKAGENAME.equals(action)) {
            String packageName = args.optString(0);
            if (!packageName.isEmpty()) {
                if (mat != null) {
                    mat.setPackageName(packageName);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETPAYINGUSER.equals(action)) {
            boolean payingUser = args.optBoolean(0);
            if (mat != null) {
                mat.setIsPayingUser(payingUser);
            }
            callbackContext.success();
            return true;
        } else if (SETTPID.equals(action)) {
            String tpid = args.optString(0);
            if (!tpid.isEmpty()) {
                if (mat != null) {
                    mat.setTRUSTeId(tpid);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETUSEREMAIL.equals(action)) {
            String userEmail = args.optString(0);
            if (!userEmail.isEmpty()) {
                if (mat != null) {
                    mat.setUserEmail(userEmail);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETUSERID.equals(action)) {
            String userId = args.optString(0);
            if (!userId.isEmpty()) {
                if (mat != null) {
                    mat.setUserId(userId);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETUSERNAME.equals(action)) {
            String userName = args.optString(0);
            if (!userName.isEmpty()) {
                if (mat != null) {
                    mat.setUserName(userName);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETFBUSERID.equals(action)) {
            String userId = args.optString(0);
            if (!userId.isEmpty()) {
                if (mat != null) {
                    mat.setFacebookUserId(userId);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETTWUSERID.equals(action)) {
            String userId = args.optString(0);
            if (!userId.isEmpty()) {
                if (mat != null) {
                    mat.setTwitterUserId(userId);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETGGUSERID.equals(action)) {
            String userId = args.optString(0);
            if (!userId.isEmpty()) {
                if (mat != null) {
                    mat.setGoogleUserId(userId);
                }
            }
            callbackContext.success();
            return true;
        } else if (SETPRELOADDATA.equals(action)) {
            // Parse preload data from first arg
            JSONObject preloadData = args.optJSONObject(0);
            if (preloadData != null && mat != null) {
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
                    // Create MATPreloadData from JSONObject fields
                    MATPreloadData matPreloadData = new MATPreloadData(publisherId)
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
                    mat.setPreloadedApp(matPreloadData);
                }
            }
            callbackContext.success();
            return true;
        } else if (GETMATID.equals(action)) {
            String matId = mat.getMatId();
            callbackContext.success(matId);
            return true;
        } else if (GETOPENLOGID.equals(action)) {
            String logId = mat.getOpenLogId();
            callbackContext.success(logId);
            return true;
        } else if (GETISPAYINGUSER.equals(action)) {
            boolean payingUser = mat.getIsPayingUser();
            callbackContext.success(String.valueOf(payingUser));
            return true;
        } else if (SETDELEGATE.equals(action)) {
            // default to true
            boolean enabled = args.optBoolean(0, true);
            if (enabled) {
                mat.setMATResponse(new MATResponse() {
                    @Override
                    public void enqueuedActionWithRefId(String refId) {
                    }

                    @Override
                    public void didSucceedWithData(JSONObject data) {
                        PluginResult result = new PluginResult(PluginResult.Status.OK, data.toString());
                        callbackContext.sendPluginResult(result);
                    }

                    @Override
                    public void didFailWithError(JSONObject error) {
                        PluginResult result = new PluginResult(PluginResult.Status.ERROR, error.toString());
                        callbackContext.sendPluginResult(result);
                    }
                });
            }
            return true;
        } else if (SHOWBANNER.equals(action)) {
            return showBanner(args, callbackContext);
        } else if (HIDEBANNER.equals(action)) {
            return hideBanner(args, callbackContext);
        } else if (CACHEINTERSTITIAL.equals(action)) {
            return cacheInterstitial(args, callbackContext);
        } else if (SHOWINTERSTITIAL.equals(action)) {
            return showInterstitial(args, callbackContext);
        } else {
            callbackContext.error("Unsupported action on Android");
            return false;
        }
    }

    private boolean showBanner(final JSONArray args, final CallbackContext callbackContext) {
        final String placement = args.optString(0);
        // Parse TuneAdMetadata from second arg
        final JSONObject adMetadata = args.optJSONObject(1);
        // Parse TuneBannerPosition from third arg
        final TuneBannerPosition bannerPosition = TuneBannerPosition.values()[args.optInt(2)];
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (banner == null) {
                    banner = new TuneBanner(cordova.getActivity());
                    RelativeLayout.LayoutParams params = new RelativeLayout.LayoutParams(
                            RelativeLayout.LayoutParams.MATCH_PARENT,
                            RelativeLayout.LayoutParams.MATCH_PARENT);
                    cordova.getActivity().getWindow().addContentView(banner, params);
                }
                banner.setPosition(bannerPosition);

                TuneAdMetadata metadata = createMetadataFromJSON(adMetadata);
                banner.show(placement, metadata);
                callbackContext.success();
            }
        });
        return true;
    }

    private boolean hideBanner(final JSONArray args, final CallbackContext callbackContext) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (banner != null) {
                    ((ViewGroup) banner.getParent()).removeView(banner);
                    banner.destroy();
                    banner = null;
                }
            }
        });
        return true;
    }

    private boolean cacheInterstitial(final JSONArray args, final CallbackContext callbackContext) {
        final String placement = args.optString(0);
        // Parse TuneAdMetadata from second arg
        final JSONObject adMetadata = args.optJSONObject(1);
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (interstitial == null) {
                    interstitial = new TuneInterstitial(cordova.getActivity());
                }
                TuneAdMetadata metadata = createMetadataFromJSON(adMetadata);
                interstitial.cache(placement, metadata);
                callbackContext.success();
            }
        });
        return true;
    }

    private boolean showInterstitial(final JSONArray args, final CallbackContext callbackContext) {
        final String placement = args.optString(0);
        // Parse TuneAdMetadata from second arg
        final JSONObject adMetadata = args.optJSONObject(1);
        cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (interstitial == null) {
                    interstitial = new TuneInterstitial(cordova.getActivity());
                }
                TuneAdMetadata metadata = createMetadataFromJSON(adMetadata);
                interstitial.show(placement, metadata);
                callbackContext.success();
            }
        });
        return true;
    }

    private TuneAdMetadata createMetadataFromJSON(JSONObject jsonMetadata) {
        TuneAdMetadata metadata = new TuneAdMetadata();
        if (jsonMetadata != null) {
            String gender       = jsonMetadata.optString("gender");
            double birthdate    = jsonMetadata.optDouble("birthdate");
            double latitude     = jsonMetadata.optDouble("latitude");
            double longitude    = jsonMetadata.optDouble("longitude");
            JSONArray keywords  = jsonMetadata.optJSONArray("keywords");
            JSONObject targets  = jsonMetadata.optJSONObject("customTargets");
            boolean debug       = jsonMetadata.optBoolean("debug");

            // Set TuneAdMetadata params from JavaScript json if they exist
            if (!gender.isEmpty()) {
                if (gender.toLowerCase().equals("male")) {
                    metadata.withGender(MATGender.MALE);
                } else {
                    metadata.withGender(MATGender.FEMALE);
                }
            }
            if (!Double.isNaN(birthdate)) {
                metadata.withBirthDate(new Date((long)birthdate));
            }
            if (!Double.isNaN(latitude) && !Double.isNaN(longitude)) {
                metadata.withLocation(latitude, longitude);
            }
            if (keywords != null) {
                // Convert JSONArray to Set<String>
                HashSet<String> set = new HashSet<String>();
                for (int i = 0; i < keywords.length(); i++) {
                    String keyword = keywords.optString(i);
                    if (!keyword.isEmpty()) {
                        set.add(keyword);
                    }
                }
                metadata.withKeywords(set);
            }
            if (targets != null) {
                // Convert JSONObject to Map<String, String>
                HashMap<String, String> map = new HashMap<String, String>();
                Iterator<String> keys = targets.keys();

                while (keys.hasNext()) {
                    String key = keys.next();
                    try {
                        Object value = targets.get(key);
                        if (value instanceof String) {
                            map.put(key, (String)value);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                metadata.withCustomTargets(map);
            }
            metadata.withDebugMode(debug);
        }
        return metadata;
    }


    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
        if (banner != null) {
            banner.resume();
        }
    }

    @Override
    public void onPause(boolean multitasking) {
        if (banner != null) {
            banner.pause();
        }
        super.onPause(multitasking);
    }

    @Override
    public void onDestroy() {
        if (banner != null) {
            banner.destroy();
            banner = null;
        }
        super.onDestroy();
    }
}
