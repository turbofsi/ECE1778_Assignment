//
//  DetailViewController.m
//  A4Demo
//
//  Created by  吕欣韵 on 2015-01-19.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "DetailViewController.h"
#import "userDB.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


static int i = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"array: %@", _showArray);
    
    
    NSString *urlStr = [self convertStr:_showArray[i]];
    NSURL *url = [NSURL URLWithString:urlStr];
    [self loadWebPageWithString:url];
}

- (void)loadWebPageWithString:(NSURL *)url
{
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webShow loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)convertStr: (NSString *)str{
    NSString *append = [str stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *urlBaseStr = @"https://www.google.ca/?gws_rd=ssl#q=";
    NSString *result = [NSString stringWithFormat:@"%@%@", urlBaseStr, append];
    return result;
}

- (IBAction)backAction:(UIButton *)sender {
    i++;
    if (i < [_showArray count]) {
        NSString *loadStr = [self convertStr:_showArray[i]];
        NSURL *url = [NSURL URLWithString:loadStr];
        [self loadWebPageWithString:url];
    }
   
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
@end
