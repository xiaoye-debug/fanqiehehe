#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// TG频道：https://t.me/iosrxwy/

%hook SSAccountInfo
- (_Bool)isVip {
    return YES;
}
%end

%hook SSVipInfo
// VIP剩余时间
- (id)leftTime {
    return [NSString stringWithFormat:@"%.0lf", 2534308005 - [[NSDate date] timeIntervalSince1970]];
}

// VIP到期时间,20990113
- (id)expireTime {
    return @"4071916800";
}

- (id)isVip {
    return @"1";
}
%end

// 顺便解锁番茄畅听等
%hook SSUser
- (bool)isVip {
    return 1;
}
%end

%hook BUSplashAdView
- (void)setSlot:(id)arg1 {
}
%end

// 移除阅读页面插入广告
%hook BDReaderViewController
- (id)tryGetInsertedVC:(id)arg1 fromPageContext:(id)arg2 toPageContext:(id)arg3 {
    return nil;
}
%end

%hook SSAdReaderCommonEntranceView
- (id)initWithFrame:(struct CGRect)arg1 {
    id view = %orig;
    [view setAlpha:0];
    [view setHidden:YES];
    return view;
}
%end


// ===== Bundle ID 测试重写 =====
// 仅使用本插件自有的测试 Bundle ID，不用于第三方服务认证或登录绕过。
static NSString * const kFQHTestBundleIdentifier = @"com.xiaoye-debug.fanqiehehe.test";
static NSString * const kFQHBundleIDSwitchKey = @"fanqieheheEnableBundleIDTestRewrite";

static BOOL FQHBundleIDTestRewriteEnabled(void) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kFQHBundleIDSwitchKey];
}

%hook NSBundle

- (NSString *)bundleIdentifier {
    NSString *original = %orig;

    // 只处理主 Bundle，并且只在用户开启测试开关时生效。
    // 测试值固定为本插件自有的测试 ID。
    if (FQHBundleIDTestRewriteEnabled() &&
        self == [NSBundle mainBundle] &&
        original.length > 0) {
        return kFQHTestBundleIdentifier;
    }

    return original;
}

- (id)objectForInfoDictionaryKey:(NSString *)key {
    id value = %orig;

    if (FQHBundleIDTestRewriteEnabled() &&
        self == [NSBundle mainBundle] &&
        [key isEqualToString:@"CFBundleIdentifier"]) {
        return kFQHTestBundleIdentifier;
    }

    return value;
}

%end
