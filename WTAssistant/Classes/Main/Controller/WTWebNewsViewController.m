//
//  WTWebNewsViewController.m
//  WTAssistant
//
 
//  Copyright © 2016年 Gaooof. All rights reserved.
//

#import "WTWebNewsViewController.h"
#import "WTMessageNews.h"
@interface WTWebNewsViewController ()

@end

@implementation WTWebNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:self.view.frame];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    webView.scalesPageToFit=YES;
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
