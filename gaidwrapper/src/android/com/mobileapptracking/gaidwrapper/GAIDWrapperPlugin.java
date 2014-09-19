package com.mobileapptracking.gaidwrapper;

import java.io.IOException;
import java.lang.NullPointerException;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.google.android.gms.ads.identifier.AdvertisingIdClient;
import com.google.android.gms.ads.identifier.AdvertisingIdClient.Info;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;

public class GAIDWrapperPlugin extends CordovaPlugin {
    public static final String GETGAID = "getGAID";
    
    public String advertisingId;
    public boolean isLAT;

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) {
        if (GETGAID.equals(action)) {
            cordova.getThreadPool().execute(new GetGAIDThread(this.cordova.getActivity(), callbackContext));
            return true;
        } else {
            callbackContext.error("Unsupported action on Android");
            return false;
        }
    }
    
    class GetGAIDThread implements Runnable {
        Context mContext;
        CallbackContext cbc;
        
        public GetGAIDThread(Context context, CallbackContext callbackContext) {
            this.mContext = context;
            this.cbc = callbackContext;
        }
        
        @Override
        public void run() {
            try {
                Info adInfo = AdvertisingIdClient.getAdvertisingIdInfo(mContext);
                advertisingId = adInfo.getId();
                isLAT = adInfo.isLimitAdTrackingEnabled();
            } catch (IOException e) {
                // Unrecoverable error connecting to Google Play services (e.g.,
                // the old version of the service doesn't support getting AdvertisingId).
                cbc.error(e.getMessage());
            } catch (GooglePlayServicesNotAvailableException e) {
                // Google Play services is not available entirely.
                cbc.error(e.getMessage());
            } catch (GooglePlayServicesRepairableException e) {
                cbc.error(e.getMessage());
            } catch (NullPointerException e) {
                cbc.error(e.getMessage());
            }

            JSONObject retVal = new JSONObject();
            try {
                retVal.put("gaid", advertisingId);
                retVal.put("isLAT", isLAT);
            } catch (JSONException e) {
                cbc.error(e.getMessage());
            }
            cbc.success(retVal);
        }
    }
}