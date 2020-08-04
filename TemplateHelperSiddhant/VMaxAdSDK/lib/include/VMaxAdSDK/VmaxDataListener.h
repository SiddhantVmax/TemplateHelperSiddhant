//
//  VmaxDataListener.h
//  VMaxAdSDK
//
//  Created by admin_vserv on 04/06/20.
//  Copyright © 2020 Vserv.mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VMaxAdView.h"
#import "VMaxAdSDK.h"
#import "VMaxAdDelegate.h"
#import "VMaxAdPartner.h"
#import "VMaxNativeAd.h"
#import "VMaxVideoAd.h"
#import "VmaxAdTemplateListener.h"
#import "VMaxAdError.h"
#import "VmaxTracker.h"

@class VmaxTracker;

typedef NS_ENUM(NSUInteger, AdOptionKey) {
    SCREEN_TYPE
};

typedef NS_ENUM(NSUInteger, AdOptionValue) {
    SCREEN_MID,
    SCREEN_END
};

typedef NS_ENUM(NSUInteger, VmaxAdAsset) {
    asset_ImageIcon,//brand page
    asset_Title,//brand page
    asset_Replay
};

NS_ASSUME_NONNULL_BEGIN

@interface VmaxDataListener : NSObject
- (void)onSuccess:(NSString *)data vmaxAdView:(VMaxAdView *)vmaxAdView;
- (void)onFailure:(VMaxAdError *)error vmaxAdView:(VMaxAdView *)vmaxAdView;
- (void)onAdLoaded:(NSString *)data vmaxAdView:(VMaxAdView *)vmaxAdView;
- (void)onAdElementClicked:(VmaxAdAsset)typeClicked vmaxAdView:(VMaxAdView *)vmaxAdView;
- (void)onAdCloseLoaded:(VMaxAdView *)vmaxAdView;
- (void)onAdSkipables:(VMaxAdView *)vmaxAdView;
@end
NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface VmaxAdFactory : NSObject

@property (nonatomic) NSMutableDictionary *appTemplateList;

+ (id)getInstance;

- (void)addTemplate:(NSString *)templateName adData:(id)vmaxAdClassName;

- (void)setTemplate:(NSDictionary *)templates;
//- (VMaxAd *)getVmaxAdTemplate:(NSString *)templateName adData:(id)adData;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface VmaxAdTwo : NSObject
- (void)parse:(NSString *)payload;
@end

NS_ASSUME_NONNULL_END




//NS_ASSUME_NONNULL_BEGIN
//
//@interface VmaxTemplateHelper : NSObject
//
//
//- (void)registerTeplate;
//
//@end
//
//NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface VMaxAd : NSObject
@property (strong, nonatomic) NSString* iconUrl;
@property (strong, nonatomic) NSString* postId;
@property (strong, nonatomic) NSString* adOffset;
@property (strong, nonatomic) NSString* adId;
@property (nonatomic, strong) VmaxTracker *vmaxTracker;

- (NSString *)getIconUrl;
- (NSString *)getPostId;
- (NSString *)getAdOffset;
- (void)getAdId:(NSString *)adId;
- (VmaxTracker *)getVmaxTracker;
- (void)parse:(NSData *)payload adData:(NSDictionary *)adData vmaxDataListener:(VmaxDataListener *)vmaxDataListener vmaxAdView:(VMaxAdView *)vmaxAdView templateName:(NSString *)templateName;
- (void)render:(VmaxAdTemplateListener *)vmaxAdTemplateListener adScreenType:(NSNumber *)adScreenType viewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
@interface VmaxAdSpot : NSObject
@property (strong,nonatomic) VMaxAdView *vmaxAdView;
@property (strong,nonatomic) NSString *urls;
@property (strong,nonatomic) NSString *adId;
@property (strong,nonatomic) NSString *campaignId;
@property (strong,nonatomic) NSString *adSpotKey;
@property (strong,nonatomic) UIViewController *vc;
-(id)initWithAdSpotKey:(NSString *)adSpotKey vc:(UIViewController *)vc;
-(void)getAd:(NSString *)campaignId adId:(NSString *)adId;
-(void)releaseAd;
-(void)setRefreshTime:(NSInteger)refreshTime;

@end
NS_ASSUME_NONNULL_END
