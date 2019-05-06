## Functions

<dl>
<dt><a href="#initTune">initTune(tuneAdvertiserId, tuneConversionKey, tunePackageName)</a></dt>
<dd></dd>
<dt><a href="#setDebugMode">setDebugMode(enable)</a></dt>
<dd></dd>
<dt><a href="#setAppAdTrackingEnabled">setAppAdTrackingEnabled(enable)</a></dt>
<dd></dd>
<dt><a href="#getTuneId">getTuneId(success, failure)</a></dt>
<dd></dd>
<dt><a href="#getOpenLogId">getOpenLogId(success, failure)</a></dt>
<dd></dd>
<dt><a href="#getIsPayingUser">getIsPayingUser(success, failure)</a></dt>
<dd></dd>
<dt><a href="#getIsPrivacyProtectedDueToAge">getIsPrivacyProtectedDueToAge(success, failure)</a></dt>
<dd><p>This will be true if either the age is set to less than 13 or if setPrivacyProtectedDueToAge(boolean) is set to true.</p>
</dd>
<dt><a href="#registerDeeplinkListener">registerDeeplinkListener(success, failure)</a></dt>
<dd><p>This will be called when either a deferred deeplink is found for a fresh install or for handling an opened Tune Link.  Registering a deeplink listener will trigger an asynchronous call to check for deferred deeplinks</p>
</dd>
<dt><a href="#unregisterDeeplinkListener">unregisterDeeplinkListener()</a></dt>
<dd><p>Remove the deeplink listener previously set with registerDeeplinkListener().</p>
</dd>
<dt><a href="#setExistingUser">setExistingUser(existingUser)</a></dt>
<dd><p>This is generally used to distinguish users who were using previous versions of the
app, prior to integration of the Tune SDK. The default is to assume a new user.</p>
</dd>
<dt><a href="#setFacebookEventLogging">setFacebookEventLogging(enable, limit)</a></dt>
<dd><p>This flag is ignored if the Facebook SDK is not present.</p>
</dd>
<dt><a href="#setPayingUser">setPayingUser(payingUser)</a></dt>
<dd><p>If measureEvent is called with a non-zero revenue, this is automatically set to YES.</p>
</dd>
<dt><a href="#setPreloadedAppData">setPreloadedAppData(preloadData)</a></dt>
<dd></dd>
<dt><a href="#setPrivacyProtectedDueToAge">setPrivacyProtectedDueToAge(isPrivacyProtected)</a></dt>
<dd><p>Set this device profile as privacy protected for the purposes of the protection of children from ad targeting and personal data collection. In the US this is part of the COPPA law.</p>
</dd>
<dt><a href="#setUseId">setUseId(userId)</a></dt>
<dd></dd>
<dt><a href="#measureSession">measureSession()</a></dt>
<dd></dd>
<dt><a href="#measureEvent">measureEvent(tuneEvent)</a></dt>
<dd></dd>
<dt><a href="#isTuneLink">isTuneLink(appLinkUrl, success, failure)</a></dt>
<dd><p>Tune Links are Tune-hosted App Links. Tune Links are often shared as short-urls, and the Tune SDK will handle expanding the url and returning the in-app destination url to didReceiveDeeplink registered via registerDeeplinkListener.</p>
</dd>
</dl>

<a name="initTune"></a>

## initTune(tuneAdvertiserId, tuneConversionKey, tunePackageName)
**Kind**: global function  
**Summary**: Initializes the TUNE SDK.  

| Param | Type | Description |
| --- | --- | --- |
| tuneAdvertiserId | <code>string</code> | TUNE advertiser ID |
| tuneConversionKey | <code>string</code> | TUNE conversion key |
| tunePackageName | <code>string</code> | Optional value to set the package name |

<a name="setDebugMode"></a>

## setDebugMode(enable)
**Kind**: global function  
**Summary**: Turns debug mode on or off.  

| Param | Type | Description |
| --- | --- | --- |
| enable | <code>boolean</code> | whether to enable debug output |

<a name="setAppAdTrackingEnabled"></a>

## setAppAdTrackingEnabled(enable)
**Kind**: global function  
**Summary**: Sets whether app-level ad tracking is enabled.  

| Param | Type | Description |
| --- | --- | --- |
| enable | <code>boolean</code> | true if user has opted-in of ad tracking, false if not |

<a name="getTuneId"></a>

## getTuneId(success, failure)
**Kind**: global function  
**Summary**: Gets the TUNE ID generated on install  

| Param | Type | Description |
| --- | --- | --- |
| success | <code>callback</code> | Callback returns the TUNE ID. |
| failure | <code>callback</code> | Callback Message if there was an error. |

<a name="getOpenLogId"></a>

## getOpenLogId(success, failure)
**Kind**: global function  
**Summary**: Gets the first TUNE open log ID  

| Param | Type | Description |
| --- | --- | --- |
| success | <code>callback</code> | Callback returns the first TUNE open log ID. |
| failure | <code>callback</code> | Callback Message if there was an error. |

<a name="getIsPayingUser"></a>

## getIsPayingUser(success, failure)
**Kind**: global function  
**Summary**: Gets whether the user is revenue-generating or not  

| Param | Type | Description |
| --- | --- | --- |
| success | <code>callback</code> | Callback returns true if the user is revenue-generating, or false if not. |
| failure | <code>callback</code> | Callback Message if there was an error. |

<a name="getIsPrivacyProtectedDueToAge"></a>

## getIsPrivacyProtectedDueToAge(success, failure)
This will be true if either the age is set to less than 13 or if setPrivacyProtectedDueToAge(boolean) is set to true.

**Kind**: global function  
**Summary**: Returns whether this device profile is flagged as privacy protected.  

| Param | Type | Description |
| --- | --- | --- |
| success | <code>callback</code> | Callback returns true if the age has been set to less than 13 OR this profile has been set explicitly as privacy protected. |
| failure | <code>callback</code> | Callback Message if there was an error. |

<a name="registerDeeplinkListener"></a>

## registerDeeplinkListener(success, failure)
This will be called when either a deferred deeplink is found for a fresh install or for handling an opened Tune Link.  Registering a deeplink listener will trigger an asynchronous call to check for deferred deeplinks

**Kind**: global function  
**Summary**: Set the deeplink listener that will be called.  

| Param | Type | Description |
| --- | --- | --- |
| success | <code>callback</code> | Callback returns if successfully did Receive a Deeplink |
| failure | <code>callback</code> | Callback Message if registration failed. |

<a name="unregisterDeeplinkListener"></a>

## unregisterDeeplinkListener()
Remove the deeplink listener previously set with registerDeeplinkListener().

**Kind**: global function  
**Summary**: Unregister the deeplink listener.  
<a name="setExistingUser"></a>

## setExistingUser(existingUser)
This is generally used to distinguish users who were using previous versions of the
app, prior to integration of the Tune SDK. The default is to assume a new user.

**Kind**: global function  
**Summary**: Set whether this is an existing user or a new one.  
**See**: http://support.mobileapptracking.com/entries/22621001-Handling-Installs-prior-to-SDK-implementation  

| Param | Type | Description |
| --- | --- | --- |
| existingUser | <code>boolean</code> | true if this user already had the app installed prior to updating to TUNE |

<a name="setFacebookEventLogging"></a>

## setFacebookEventLogging(enable, limit)
This flag is ignored if the Facebook SDK is not present.

**Kind**: global function  
**Summary**: Set whether the Tune events should also be logged to the Facebook SDK.  

| Param | Type | Description |
| --- | --- | --- |
| enable | <code>boolean</code> | Whether to send Tune events to FB as well |
| limit | <code>boolean</code> | Whether data such as that generated through FBAppEvents and sent to Facebook should be restricted from being used for other than analytics and conversions. |

<a name="setPayingUser"></a>

## setPayingUser(payingUser)
If measureEvent is called with a non-zero revenue, this is automatically set to YES.

**Kind**: global function  
**Summary**: Set whether the user is generating revenue for the app or not.  

| Param | Type | Description |
| --- | --- | --- |
| payingUser | <code>boolean</code> | true if the user is revenue-generating, false if not |

<a name="setPreloadedAppData"></a>

## setPreloadedAppData(preloadData)
**Kind**: global function  
**Summary**: Sets publisher information for attribution.  

| Param | Type | Description |
| --- | --- | --- |
| preloadData | <code>object</code> | Preload app attribution data (JSON) |

<a name="setPrivacyProtectedDueToAge"></a>

## setPrivacyProtectedDueToAge(isPrivacyProtected)
Set this device profile as privacy protected for the purposes of the protection of children from ad targeting and personal data collection. In the US this is part of the COPPA law.

**Kind**: global function  
**Summary**: Set privacy as protected.  

| Param | Type | Description |
| --- | --- | --- |
| isPrivacyProtected | <code>boolean</code> | true if privacy should be protected for this user. |

<a name="setUseId"></a>

## setUseId(userId)
**Kind**: global function  
**Summary**: Sets the user ID.  

| Param | Type | Description |
| --- | --- | --- |
| userId | <code>string</code> | The string name for the user ID. |

<a name="measureSession"></a>

## measureSession()
**Kind**: global function  
**Summary**: To be called when an app opens.
TODO: Handle Android activity lifecycle on init  
<a name="measureEvent"></a>

## measureEvent(tuneEvent)
**Kind**: global function  
**Summary**: Record an event with a TuneEvent.  

| Param | Type | Description |
| --- | --- | --- |
| tuneEvent | <code>object</code> | the TuneEvent.  Can be a number, string, or JSON object. |

<a name="isTuneLink"></a>

## isTuneLink(appLinkUrl, success, failure)
Tune Links are Tune-hosted App Links. Tune Links are often shared as short-urls, and the Tune SDK will handle expanding the url and returning the in-app destination url to didReceiveDeeplink registered via registerDeeplinkListener.

**Kind**: global function  
**Summary**: Test if your custom Tune Link domain is registered with Tune.  

| Param | Type | Description |
| --- | --- | --- |
| appLinkUrl | <code>string</code> | url to test if it is a Tune Link. Must not be null. |
| success | <code>callback</code> | Callback returns true if this link is a Tune Link that will be measured by Tune and routed into the TuneDeeplinkListener.  false if not. |
| failure | <code>callback</code> | Callback Message if there was an error. |

