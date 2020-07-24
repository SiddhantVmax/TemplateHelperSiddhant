//
//  VMaxOM.m
//  VMaxSample
//
//  Created by Prashant Sidd on 21/08/19.
//  Copyright © 2019 VMax. All rights reserved.
//

#import "VMaxOM.h"
//#import <OMSDK_Vmax/OMIDSDK.h>
//#import <OMSDK_Vmax/OMIDAdEvents.h>
//#import <OMSDK_Vmax/OMIDVASTProperties.h>
//#import <OMSDK_Vmax/OMIDVideoEvents.h>
//#import <OMSDK_Vmax/OMIDScriptInjector.h>
//#import <OMSDK_Vmax/OMIDVerificationScriptResource.h>
//#import <OMSDK_Vmax/OMIDImports.h>
//#import <OMSDK_Vmax/OMIDPartner.h>
//#import <OMSDK_Vmax/OMIDVideoEvents.h>
//#import <OMSDK_Vmax/OMIDAdSessionContext.h>
//#import <OMSDK_Vmax/OMIDAdSessionConfiguration.h>

#import <OMSDK_Zeedigitalesselgroup/OMIDAdEvents.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDAdSession.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDAdSessionConfiguration.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDAdSessionContext.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDFriendlyObstructionType.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDImports.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDMediaEvents.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDPartner.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDScriptInjector.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDSDK.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDVASTProperties.h>
#import <OMSDK_Zeedigitalesselgroup/OMIDVerificationScriptResource.h>
#import "VMaxCustomAd.h"

#define BUNDLEID    [NSString stringWithString:[[NSBundle mainBundle] bundleIdentifier]] ? [NSString stringWithString:[[NSBundle mainBundle] bundleIdentifier]] : @""

typedef NS_ENUM(NSUInteger,VastEventType) {
    kVMaxOMAdState_Started,
    kVMaxOMAdState_Stopped ,
    kVMaxOMAdState_Completed ,
    kVMaxOMAdState_Click ,
    kVMaxOMAdState_FirstQuartile,
    kVMaxOMAdState_Midpoint,
    kVMaxOMAdState_ThirdQuartile,
    kVMaxOMAdState_Pause,
    kVMaxOMAdState_Collapse,
    kVMaxOMAdState_Error,
    kVMaxOMAdState_Mute,
    kVMaxOMAdState_Unmute,
    kVMaxOMAdState_Skipped,
    kVMaxOMAdState_Expand
};

@interface VMaxOM ()

//@property (strong, nonatomic) OMIDVmaxAdSession *adSession;
//@property (strong, nonatomic) OMIDVmaxAdEvents *adEvents;
//@property (strong, nonatomic) OMIDVmaxVideoEvents *omidVideoEvents;
//@property (strong, nonatomic) AVAudioPlayer * avPlayerVideoPlayer;

@end

Boolean isOMSdkActivated = false;
OMIDZeedigitalesselgroupPartner *partner;
OMIDZeedigitalesselgroupAdSession *adSession;
OMIDZeedigitalesselgroupAdEvents *adEvents;
OMIDZeedigitalesselgroupMediaEvents *omidVideoEvents;
AVPlayer * avPlayerVideoPlayer;
NSString *strScript;
UIView *viewMainAdPlayerView;

@implementation VMaxOM 

#pragma mark Activate the OM SDK

- (void)activateOMSDK {
    
    NSError *error;
    
    // changes siddhant
    isOMSdkActivated = [[OMIDZeedigitalesselgroupSDK sharedInstance] activate];
    
    partner = [[OMIDZeedigitalesselgroupPartner alloc] initWithName:@"Zeedigitalesselgroup" versionString:@"A-IO-3.13.0"];
    
    // changed over
    if (error == nil) {

        if (isOMSdkActivated) {
            VLog(@"OM_vmax : Activate OMID SDK:");
        }
        else {
            VLog([NSString stringWithFormat:@"OM_vmax : Unable to activate OMID SDK: %@",error]);
        }
    }
    else {
        VLog([NSString stringWithFormat:@"OM_vmax : Unable to activate OMID SDK: %@",error]);
    }
}

-(void)script {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"vmax_omid" ofType:@"js"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    strScript = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark Register Display Ad

-(void)registerDisplayAd :(WKWebView *)webView andview:(UIView *)playerView andfriendlyObstructions:(NSMutableArray *)friendlyObstructions {
    
    if (isOMSdkActivated) {
        VLog(@"OM_vmax : Initializing OM Display Ad Session");
        NSString *customReferenceData;
        NSError *adSessionContextError;
    
// changed siddhant
        OMIDZeedigitalesselgroupAdSessionContext *context = [[OMIDZeedigitalesselgroupAdSessionContext alloc] initWithPartner:partner webView:webView contentUrl:nil customReferenceIdentifier:customReferenceData error:&adSessionContextError];

        // changed over
        OMIDOwner owner = OMIDNativeOwner;
        NSError *adSessionConfigurationError;
        // changed siddhant
        OMIDZeedigitalesselgroupAdSessionConfiguration *config = [[OMIDZeedigitalesselgroupAdSessionConfiguration alloc] initWithCreativeType:OMIDCreativeTypeHtmlDisplay impressionType:OMIDImpressionTypeBeginToRender impressionOwner:OMIDNativeOwner mediaEventsOwner:OMIDNoneOwner isolateVerificationScripts:false error:NULL];
        
        //
        
        // changed siddhant
        adSession = [[OMIDZeedigitalesselgroupAdSession alloc] initWithConfiguration:config
                                                    adSessionContext:context error:nil];
        // changed  over
        adSession.mainAdView = webView;
//        [adSession setMainAdView:webView];
        if (playerView != nil) {
            [self registerDisplayAdFriendlyObstruction:playerView];
        }
    }
    else {
        VLog(@"OM_vmax : Unable to activate OMID SDK");
    }
}


-(void)registerDisplayAdFriendlyObstruction : (UIView *)friendlyObstructions {
    // changed siddhant
    
    // pending siddhant
//    [adSession addFriendlyObstruction:frien purpose:<#(OMIDFriendlyObstructionType)#> detailedReason:<#(nullable NSString *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
//        [adSession addFriendlyObstruction:friendlyObstructions];
    // change over
}

#pragma mark Display Start Tracking

-(void)displayStartTracking  {
    
    if (adSession != nil) {
        // Start the session
        VLog(@"OM_vmax : OM Display displayStartTracking");
        [adSession start];
        NSError *adEvtsError;
//        adEvents = [[OMIDVmaxAdEvents alloc] initWithAdSession:adSession error:&adEvtsError];
        // changed siddhant
        adEvents = [[OMIDZeedigitalesselgroupAdEvents alloc] initWithAdSession:adSession error:&adEvtsError];
        //

        NSError *impError;
        [adEvents impressionOccurredWithError:&impError];
    }
}

#pragma mark End Display AdSeesion

-(void)endDisplayAdSession {
    
    if (adSession !=nil) {
        VLog(@"OM_vmax : Terminating Display Start Tracking");
        [adSession finish];
    }
    omidVideoEvents = nil;
    adSession = nil;
}

#pragma mark Start Vast Session

-(void)startVastAdSession :(AVPlayer *)avplayer andview:(UIView *)playerView andVendorKey:(NSString *)strVendorKey andVerificationParam:(NSString *)strVerificationParam andResourceURL:(NSString *)strResourceURL andJSServiceContent:(NSString *)strJSServiceContent andDelay:(int *)delay andisFullscreenAd:(Boolean *)isFullscreenAd andfriendlyObstructions:(NSMutableArray *)friendlyObstructions {
    
    if (isOMSdkActivated) {
        [self script];
        viewMainAdPlayerView = playerView;
        VLog(@"OM_vmax : startVastAdSession");
//        NSMutableArray *verificationScriptResources;
        NSMutableArray *scripts = [[NSMutableArray alloc]init];
        NSURL *url = [NSURL URLWithString:@"https:\/\/img.vserv.mobi\/ot\/om_resource\/1543320389.js"];
//        OMIDVmaxVerificationScriptResource *verificationScriptResource;
        if (strVendorKey.length > 0 && strVerificationParam.length > 0) {
            // changed siddhant  OMIDZeedigitalesselgroupVerificationScriptResource
//            [scripts addObject:[[OMIDVmaxVerificationScriptResource alloc] initWithURL:url vendorKey: strVendorKey
//                                                                        parameters:strVerificationParam]];
            [scripts addObject:[[OMIDZeedigitalesselgroupVerificationScriptResource alloc] initWithURL:url vendorKey:strVendorKey parameters:strVerificationParam]];
            
            // change over
        }
        else {
            // changed siddhant
//            [scripts addObject:[[OMIDVmaxVerificationScriptResource alloc] initWithURL:url]];
            [scripts addObject:[[OMIDZeedigitalesselgroupVerificationScriptResource alloc] initWithURL:url]];
            //
        }
        NSString *customReferenceData;
        NSError *adSessionContextError;
        //partner ,script, resources,customReferenceIdentifier,error
        // changed siddhant
        OMIDZeedigitalesselgroupAdSessionContext *adSessionContext = [[OMIDZeedigitalesselgroupAdSessionContext alloc] initWithPartner:partner script:scripts resources:strScript contentUrl:nil customReferenceIdentifier:customReferenceData error:&adSessionContextError];
//        OMIDVmaxAdSessionContext *adSessionContext = [[OMIDVmaxAdSessionContext alloc]initWithPartner:partner script:strScript resources:scripts customReferenceIdentifier:customReferenceData error:&adSessionContextError];
        // change over
        OMIDOwner owner = OMIDNativeOwner;
        NSError *adSessionConfigurationError;
        
        // changed siddhant
//        OMIDVmaxAdSessionConfiguration *adSessionConfiguration = [[OMIDVmaxAdSessionConfiguration alloc] initWithImpressionOwner:owner videoEventsOwner:owner isolateVerificationScripts:false error:&adSessionConfigurationError];
        
        OMIDZeedigitalesselgroupAdSessionConfiguration *adSessionConfiguration = [[OMIDZeedigitalesselgroupAdSessionConfiguration alloc] initWithCreativeType:OMIDCreativeTypeHtmlDisplay impressionType:OMIDImpressionTypeBeginToRender impressionOwner:OMIDNativeOwner mediaEventsOwner:OMIDNoneOwner isolateVerificationScripts:true error:NULL];
        
        
//        adSession = [[OMIDVmaxAdSession alloc] initWithConfiguration:adSessionConfiguration adSessionContext:adSessionContext error:nil];
        NSError *adSessionError;
         adSession = [[OMIDZeedigitalesselgroupAdSession alloc] initWithConfiguration:adSessionConfiguration adSessionContext:adSessionContext error:&adSessionError];
        [self startVastAdSessionMainAdview];
        // change over
//        [adSession setMainAdView:playerView];
        if (friendlyObstructions.count != 0) {
            VLog(@"OM_vmax : OM Vast ads friendly obstruction registered");
            for (int i=0;i<friendlyObstructions.count;i++){
                //pending
//                [adSession addFriendlyObstruction:[friendlyObstructions objectAtIndex:i]];
//                [adSession addFriendlyObstruction:<#(nonnull UIView *)#> purpose:<#(OMIDFriendlyObstructionType)#> detailedReason:<#(nullable NSString *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>]
            }
        }
//        [adSession addFriendlyObstruction:playerView];
        NSError *adEventsEroor;
        // changed siddhant
        adEvents = [[OMIDZeedigitalesselgroupAdEvents alloc] initWithAdSession:adSession error:&adEventsEroor];

        // change over
    
        // change siddhant
        omidVideoEvents = [[OMIDZeedigitalesselgroupAdEvents alloc] initWithAdSession:adSession error:&adEventsEroor];
        
        avPlayerVideoPlayer = avplayer;
        [adSession start];

        if (delay > 0) {
            // changed siddhant
            OMIDZeedigitalesselgroupVASTProperties *vProps = [[OMIDZeedigitalesselgroupVASTProperties alloc] initWithSkipOffset:*delay autoPlay:(BOOL)true position:OMIDPositionStandalone];
//            OMIDVmaxVASTProperties *vProps = [[OMIDVmaxVASTProperties alloc] initWithSkipOffset:*delay autoPlay:true position:OMIDPositionStandalone];
            NSError *errors;
            [adEvents loadedWithVastProperties:vProps error:&errors];
//           [omidVideoEvents loadedWithVastProperties:vProps];
            // change over

            VLog(@"OM_vmax : delay > 0");
        }
        else {
            // changed siddhant
            OMIDZeedigitalesselgroupVASTProperties *vProps = [[OMIDZeedigitalesselgroupVASTProperties alloc] initWithAutoPlay:true position:OMIDPositionStandalone];
//            OMIDVmaxVASTProperties *vProps = [[OMIDVmaxVASTProperties alloc] initWithAutoPlay:true position:OMIDPositionStandalone];
            
//            [omidVideoEvents loadedWithVastProperties:vProps];
            NSError *errors;
            [adEvents loadedWithVastProperties:vProps error:&errors];
        // change over
            VLog(@"OM_vmax : delay < 0");
        }
        [adEvents impressionOccurredWithError:&adEventsEroor];
        
        if (isFullscreenAd) {
            [omidVideoEvents playerStateChangeTo:OMIDPlayerStateFullscreen];
        }
        else {
            [omidVideoEvents playerStateChangeTo:OMIDPlayerStateNormal];
        }
    }
    else {
        VLog(@"OM_vmax : Unable to activate OMID SDK");
    }
}

-(void)startVastAdSessionMainAdview {
    
        [adSession setMainAdView:viewMainAdPlayerView];
}

#pragma mark End Vast Session

-(void)endVastAdSessionOM {
    
    if (adSession !=nil) {
        VLog(@"OM_vmax : Terminating OM Vast Ad session");
        [adSession finish];
    }
    omidVideoEvents = nil;
    adSession = nil;
}

#pragma mark Record Vast Event

-(void)recordVastEvent :(NSString *)strEvent {
    
    VLog(@"OM_vmax : Record Vast Event called");
    if (adSession != nil && omidVideoEvents!=nil) {
        VLog(@"OM_vmax : Registering OM Vast event= %@",strEvent);
        if ([strEvent isEqualToString:@"start"]) {
            [omidVideoEvents bufferStart];
            [avPlayerVideoPlayer setVolume:5.0];
//        setVolume:5.0 fadeDuration:1];
        }
        else if ([strEvent isEqualToString:@"complete"]) {
            [omidVideoEvents complete];
        }
        else if ([strEvent isEqualToString:@"firstQuartile"]) {
            [omidVideoEvents firstQuartile];
        }
        else if ([strEvent isEqualToString:@"midpoint"]) {
            [omidVideoEvents midpoint];
        }
        else if ([strEvent isEqualToString:@"thirdQuartile"]) {
            [omidVideoEvents thirdQuartile];
        }
        else if ([strEvent isEqualToString:@"pause"]) {
            [omidVideoEvents pause];
        }
        else if ([strEvent isEqualToString:@"resume"]) {
            [omidVideoEvents resume];
        }
        else if ([strEvent isEqualToString:@"expand"]) {
            [omidVideoEvents playerStateChangeTo:OMIDPlayerStateExpanded];
        }
        else if ([strEvent isEqualToString:@"collapse"]) {
            [omidVideoEvents playerStateChangeTo:OMIDPlayerStateCollapsed];
        }
        else if ([strEvent isEqualToString:@"mute"]) {
            [omidVideoEvents volumeChangeTo:0];
        }
        else if ([strEvent isEqualToString:@"unmute"]) {
            [omidVideoEvents volumeChangeTo:1];
        }
        else if ([strEvent isEqualToString:@"skipped"]) {
            [omidVideoEvents skipped];
        }
        else if ([strEvent isEqualToString:@"click"]) {
            [omidVideoEvents adUserInteractionWithType:OMIDInteractionTypeClick];
        }
        else {
            VLog(@"OM_vmax : No such event available for OM");
        }
    }
}

#pragma mark Start Native AdSession

-(void)startNativeAdSession :(UIView *)adview andVendorKey:(NSString *)strVendorKey andVerificationParam:(NSString *)strVerificationParam andResourceURL:(NSString *)strResourceURL andJSServiceContent:(NSString *)strJSServiceContent {
    
    [self script];
    NSMutableArray *verificationScriptResources = [[NSMutableArray alloc]init];
    if (strVendorKey.length > 0 && strVerificationParam.length > 0) {
        [verificationScriptResources addObject:[[OMIDZeedigitalesselgroupVerificationScriptResource alloc] initWithURL:[NSURL URLWithString:strResourceURL] vendorKey: strVendorKey
                                                                        parameters:strVerificationParam]];
        
        
        
//        verificationScriptResource = [[OMIDVmaxVerificationScriptResource alloc] initWithURL:[NSURL URLWithString:strResourceURL] vendorKey:strVendorKey parameters:strVerificationParam];
    }
    else {
        
        [verificationScriptResources addObject:[[OMIDZeedigitalesselgroupVerificationScriptResource alloc] initWithURL:[NSURL URLWithString:strResourceURL]]];
        
//        verificationScriptResource = [[OMIDVmaxVerificationScriptResource alloc]initWithURL:[NSURL URLWithString:strResourceURL]];
    }

//    [verificationScriptResources addObject:verificationScriptResource];
    
    NSString *customReferenceData;
    NSError *adSessionContextError;
    
    // changed siddhant
     OMIDZeedigitalesselgroupAdSessionContext *adSessionContext = [[OMIDZeedigitalesselgroupAdSessionContext alloc] initWithPartner:partner script:strScript resources:verificationScriptResources contentUrl:nil customReferenceIdentifier:customReferenceData error:&adSessionContextError];
//    OMIDVmaxAdSessionContext *adSessionContext = [[OMIDVmaxAdSessionContext alloc]initWithPartner:partner script:strScript resources:verificationScriptResources customReferenceIdentifier:customReferenceData error:&adSessionContextError];
    // changed over
    
    OMIDOwner owner = OMIDNativeOwner;
    
    NSError *adSessionConfigurationError;
    // changed siddhant
//    OMIDVmaxAdSessionConfiguration *adSessionConfiguration = [[OMIDVmaxAdSessionConfiguration alloc] initWithImpressionOwner:owner videoEventsOwner:owner isolateVerificationScripts:false error:&adSessionConfigurationError];
    OMIDZeedigitalesselgroupAdSessionConfiguration *adSessionConfiguration = [[OMIDZeedigitalesselgroupAdSessionConfiguration alloc] initWithCreativeType:OMIDCreativeTypeHtmlDisplay impressionType:OMIDImpressionTypeBeginToRender impressionOwner:OMIDNativeOwner mediaEventsOwner:OMIDNoneOwner isolateVerificationScripts:false error:NULL];
    // change over

    /*NSError *ctxError;
    OMIDVmaxAdSessionContext *context = [[OMIDVmaxAdSessionContext alloc] initWithPartner:partner
                                                                                   script:@"self.omidJS" resources:@"scripts" customReferenceIdentifier:nil error:&ctxError];
    NSError *cfgError;
    OMIDVmaxAdSessionConfiguration *config = [[OMIDVmaxAdSessionConfiguration alloc]
                                              initWithImpressionOwner:OMIDNativeOwner videoEventsOwner:OMIDNoneOwner
                                              isolateVerificationScripts:NO error:&cfgError];*/
    
    NSError *adSessionError;
    
    // changed siddhant
//    adSession = [[OMIDVmaxAdSession alloc] initWithConfiguration:adSessionConfiguration
//                                                 adSessionContext:adSessionContext error:&adSessionError];
//
    
    adSession = [[OMIDZeedigitalesselgroupAdSession alloc] initWithConfiguration:adSessionConfiguration adSessionContext:adSessionContext error:&adSessionError];
    [adSession start];
    
    // change over
    VLog(@"OM_vmax : Native Ad Session Started");

    NSError *adEvtsError;
    // changed siddhant
    OMIDZeedigitalesselgroupAdEvents *adEvents = [[OMIDZeedigitalesselgroupAdEvents alloc] initWithAdSession:adSession error:&adEvtsError];
//    OMIDVmaxAdEvents *adEvents = [[OMIDVmaxAdEvents alloc] initWithAdSession:adSession error:&adEvtsError];
    // change over
    VLog(@"OM_vmax : Native Ad Impression registered");
    NSError *impError;
    [adEvents impressionOccurredWithError:&impError];
}

-(void)endNativeAdSession {

    if (adSession != nil) {
        VLog(@"OM_vmax : Terminating OM Native Ad session");
        [adSession finish];
    }
    adSession = nil;
}

- (void)createViewabilityInstance {
    [self activateOMSDK];
}

-(void)registerNativeAdView:(UIView *)adview {
    if (isOMSdkActivated) {
        [adSession setMainAdView:adview];
        VLog(@"OM_vmax : Native Ad Session Registered");
    }
}

@end

