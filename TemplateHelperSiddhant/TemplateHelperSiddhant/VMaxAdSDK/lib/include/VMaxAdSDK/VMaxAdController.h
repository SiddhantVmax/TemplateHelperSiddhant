//
//  VMaxAdDisplayController.h


#import <Foundation/Foundation.h>

#import "VMaxWebView.h"
#import "VMaxAdView.h"
#import "VMaxRequestManager.h"
#import "VMaxMediationSelector.h" //..MOAT (3.9.0)
#import "VMaxTimer.h" //..(3.6.43) Added for closeAdAfter Timer
#import "DynamicInterstitialViewController.h"
#import "VMaxInAppBrowser.h"
@class VMaxAdView;
@class VMaxNativeAd;
NS_ASSUME_NONNULL_BEGIN

@interface VMaxAdController : NSObject
{
    BOOL  isNativeMediaViewExpanded;
}

// 3.11.7 Added
@property (nonatomic,assign)  BOOL isInvalidateCalled;

@property (nonatomic,strong) VMaxAdView *adPodController;

//..


@property (assign) BOOL hitMultiAdRequest,onlyForRenderMultiAd; //..(3.10.2) Added

@property (strong, nonatomic) NSString* multiAdDomain; //..(3.10.2) Added

@property (strong, nonatomic) VMaxWebView * webView;

@property (strong, nonatomic) VMaxWebView* cachedWebView;

@property (nonatomic,assign) VMaxAdOrientation preferedOrientation;

@property (strong, nonatomic) NSString* adspotID,*campaignid;

@property (strong, nonatomic) NSNumber* userRefreshRate;

@property (strong, nonatomic) NSNumber* refreshRate;

@property (assign, nonatomic) UInt32 requestTimeout;

@property (assign, nonatomic) UInt32 renderTimeout; // 3.11.8 Added

@property (assign, nonatomic) BOOL isAutoRefreshEnabled;

@property (assign, nonatomic) VMaxAdUX adUXType;

//@property (strong, nonatomic) VMaxAdUser* user;

@property (assign,nonatomic) BOOL generateVideoAd,isAdSkipped;

@property (strong, nonatomic) NSDictionary* viewProperty,*FCAP_Dict;

@property (strong, nonatomic) UIColor* backgroundColor;

@property (nonatomic) CGFloat transperency;

@property (assign , nonatomic) VMaxAdState adState; //.. (3.9.9) Added assign

@property (nonatomic,strong,nullable) NSString *markUp,*backUpMarkUp;

@property (assign, nonatomic, readonly) BOOL isRewardedVideo;

@property (nonatomic, strong) VMaxNativeAd* nativeAdObject;

@property (strong, nonatomic) VMaxRequestManager* adRequestManager;

@property (assign, nonatomic) VMaxTestMode testMode;

@property (assign, nonatomic) BOOL shouldHideVideoControls;

@property (nonatomic,strong) VMaxVideoAd *customVideoAd;

@property (assign, nonatomic) NSString* keyword,*languageOfArticle,*sectionCategoryStr,*pageCategoryStr;

@property (strong, nonatomic) NSDictionary* customData;

@property (strong, nonatomic) NSArray* testDevices;

//@property (strong, nonatomic) NSDictionary* adSettings;
@property (strong, nonatomic) VMaxAdSettings* adSettings;

@property (nonatomic,assign) BOOL isINLINE_DISPLAY;

@property (assign, nonatomic) BOOL isRequestSignatureChanged, doesBacKUpAdAttempted;

@property (strong,nonatomic) NSString *subscriberIDString;

@property (strong, nonatomic) NSString *jsonAssetString;

@property (strong, nonatomic) NSDictionary *dictionaryAsset;
// zeeShorts v1
@property (strong, nonatomic) NSData *payloadData;
@property (strong, nonatomic) NSDictionary *adData;
@property (strong, nonatomic) NSString* customAdType;
@property (strong, nonatomic) id customclass;
-(id) concreets:(VMaxAdContentType)inAdType payload:(NSData *)payload adHeader:(NSDictionary *)adHeader adView:(VMaxAdView *)adView adId:(NSString *)adId;
// zeeShorts v1 over
// zeeShorts v1 over
@property (nonatomic, strong) VMaxMediationSelector *mediationSelector; //MOAT
@property (nonatomic, weak) VMaxInAppBrowser *expandedBrowser; //..(3.9.16) Outter
//+(void) setLocation:(CLLocation*)location;


-(id)initWithAdView:(VMaxAdView*)inAdView
           adspotID:(NSString*)inadspotID withUxType:(VMaxAdUX)adUxType;

-(void)cacheNewAd:(VMaxAdOrientation)inOrientation;

-(void)startLoadingWithOrientation:(VMaxAdOrientation)inOrientation;

-(void)showAd;

-(void)displayAd:(VMaxAdView*)inAdContainer;

-(void)setBackgroundColor:(UIColor *)backgroundColor;

-(void)setFrame:(CGRect)inFrame;

-(void)setTestMode:(VMaxTestMode)testMode withDevices:(NSArray*)inDeviceIDFAList;

- (void)playAd;

- (void)pauseAd;

-(void)invalidateAd;
//..3.6.10
-(void)customAdMediaStart;

-(void)customAdMediaEnd;
//Audio
- (void)setBitrate:(NSInteger *)bitrateValue;
-(BOOL)getisAppIsInBackground;
-(BOOL)getisAppWillResign;
//..(3.8.2)

-(void)callToOpenSafariTabForDynamicInterstitialAdWithUrl:(NSURL *)url completion:(void (^)(void))completion;

-(BOOL)dismisAd;

-(DynamicInterstitialViewController *)getDynamicInterstitialAdController;
-(void)setAdRetriver:(VMaxAdRetriever *)retriver;
-(void)releaseAllObservers;
-(BOOL)getIsLoadFirstTime; //..(3.9.18) Outside Access

 @property (strong, nonatomic)  NSMutableDictionary *videoDurationSelectedDict; //..(3.10.3) VIDEO DURATION STORY ADDED

-(void)updateMediaSelectionForAudioAd;//..(3.11.0) DAAST

-(void)resetRequestedAdDurationForSingleAd;

//zeeShorts organic
- (void)getRequestUrl:(void(^)(NSString *httpUrl))httpUrl; 
//
@end
NS_ASSUME_NONNULL_END
