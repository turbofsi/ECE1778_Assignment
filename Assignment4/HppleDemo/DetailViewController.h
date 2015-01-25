//
//  DetailViewController.h
//  A4Demo
//
//  Created by  吕欣韵 on 2015-01-19.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *showArray;

- (IBAction)backAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webShow;

@end
