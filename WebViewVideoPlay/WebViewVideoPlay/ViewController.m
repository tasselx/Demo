//
//  ViewController.m
//  WebViewVideoPlay
//
//  Created by Tassel on 2018/4/29.
//  Copyright © 2018年 Tassel. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<WKScriptMessageHandler,WKUIDelegate>
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"jsCallOC"];
    // js注入，注入一个alert方法，页面加载完毕弹出一个对话框。
    
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"domObserver" ofType:@"js"];
    NSString *javaScriptSource = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:javaScriptSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    // forMainFrameOnly:NO(全局窗口)，yes（只限主窗口）
    [userContentController addUserScript:userScript]; // WKWebView的配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    configuration.allowsInlineMediaPlayback = YES;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    _webView.UIDelegate = self;
    [self.view addSubview:_webView];
    

    
  NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.lemaotv.com/xijupian/play/53113-1-1.html"]];
  [self.webView loadRequest:req];
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
        if ([message.name isEqualToString:@"jsCallOC"]) {
            NSString *msg = message.body;
            NSLog(@"%@",msg);
        }
}

//在JS端调用alert函数时，会触发此代理方法。
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%s",__FUNCTION__); // 确定按钮
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) { completionHandler(); }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

//JS端调用confirm函数时，会触发此方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    NSLog(@"pp");
   completionHandler(YES);
}


//JS端调用prompt函数时，会触发此方法
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler
{
    
    completionHandler(@"");
}

/*- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  NSLog(@"ReUrl %@",request.URL.absoluteString);
  return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
  
  NSLog(@"webViewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  
  NSLog(@"webViewDidFinishLoad");
  NSLog(@"webViewDidFinishLoad %@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);


}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  
  NSLog(@"didFailLoadWithError");

}*/

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
