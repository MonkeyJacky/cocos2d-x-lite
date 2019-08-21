//
//  CustomApi.m
//  biwan-mobile
//
//  Created by Jacky on 2019/8/10.
//

#import "CustomApi.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import <WebKit/WebKit.h>

#import "CustomWebView.h"


@implementation CustomApi

+ (NSString *)getWifiName
{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
    
    return ssid;
}

+ (NSString *)getMac
{
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = (id)CNCopyCurrentNetworkInfo((CFStringRef) ifname);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dic = (NSDictionary *)info;
    NSString *bssid = [dic objectForKey:@"BSSID"];
    
    return bssid;
}

+ (void)openWeb:(NSString*) url
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *view = window.rootViewController.view;
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    CustomWebView *webCtrl = [[CustomWebView alloc] init];
    [view addSubview:webCtrl.view];
    
//    [[SuspendedComponent getInstance] createSuspendButton];
    
//    WKWebView *webview = [[[WKWebView alloc] initWithFrame:view.frame] autorelease];
//    [webview loadRequest:request];
    
//    [view addSubview:webview];
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }
}

@end
