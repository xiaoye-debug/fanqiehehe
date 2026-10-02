#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

static NSString * const kFQHPreferencesDomain = @"com.iosrxwy.fanqiehehe";

@interface FQHRootListController : PSListController
@end

@implementation FQHRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        NSMutableArray *specifiers = [NSMutableArray array];

        PSSpecifier *header = [PSSpecifier preferenceSpecifierNamed:@"功能设置"
                                                               target:nil
                                                                  set:nil
                                                                  get:nil
                                                               detail:nil
                                                                 cell:PSGroupCell
                                                                 edit:nil];
        [specifiers addObject:header];

        PSSpecifier *bundleIDSwitch =
            [PSSpecifier preferenceSpecifierNamed:@"修改 Bundle ID"
                                           target:self
                                              set:@selector(setBundleIDSwitch:specifier:)
                                              get:@selector(bundleIDSwitch:)
                                           detail:nil
                                             cell:PSSwitchCell
                                             edit:nil];

        [bundleIDSwitch setProperty:@"fanqieheheEnableBundleIDTestRewrite" forKey:@"key"];
        [bundleIDSwitch setProperty:kFQHPreferencesDomain forKey:@"defaults"];
        [bundleIDSwitch setProperty:@NO forKey:@"default"];
        [bundleIDSwitch setProperty:@"开启后启用本插件的 Bundle ID 测试开关。仅保存本地开关状态，不修改第三方服务的认证身份。" forKey:@"footerText"];
        [specifiers addObject:bundleIDSwitch];

        PSSpecifier *info = [PSSpecifier preferenceSpecifierNamed:@"说明"
                                                           target:nil
                                                              set:nil
                                                              get:nil
                                                           detail:nil
                                                             cell:PSGroupCell
                                                             edit:nil];
        [info setProperty:@"该开关用于测试环境。开启/关闭后重新启动目标 App 以确保相关模块重新读取设置。" forKey:@"footerText"];
        [specifiers addObject:info];

        _specifiers = [specifiers copy];
    }
    return _specifiers;
}

- (id)bundleIDSwitch:(PSSpecifier *)specifier {
    return @([[NSUserDefaults standardUserDefaults] boolForKey:@"fanqieheheEnableBundleIDTestRewrite"]);
}

- (void)setBundleIDSwitch:(id)value specifier:(PSSpecifier *)specifier {
    BOOL enabled = [value boolValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:enabled forKey:@"fanqieheheEnableBundleIDTestRewrite"];
    [defaults synchronize];
}

@end
