//
//  ViewController.m
//  A1demo1222
//
//  Created by  吕欣韵 on 2014-12-24.
//  Copyright (c) 2014 UofT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *pic = [UIImage imageNamed:@"dog"];
//    self.picView = [[UIImageView alloc] init];
    
//    _picView.image = pic;
    
    _btn1Style.backgroundColor = [UIColor orangeColor];
    _btn2Style.backgroundColor = [UIColor orangeColor];
    _btn1Style.titleLabel.textColor = [UIColor whiteColor];
    _btn2Style.titleLabel.textColor = [UIColor whiteColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
static int a = 0;
- (IBAction)changeTxt:(UIButton *)sender {
    a++;
    self.txtLabel.text = [NSString stringWithFormat:@"Clicked %d times", a];
    
}
static int b = 0;
- (IBAction)showPic:(UIButton *)sender {
    b++;
    
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelay:0];

    if (b % 2 == 1) {
        _picView.alpha = 1;
    }
    else{
        _picView.alpha = 0;
    }
    
    [UIView commitAnimations];
    
    
    
}

- (IBAction)resetNumber:(UIBarButtonItem *)sender {
    a = 0;
    b = 0;
    self.txtLabel.text = @"No Clicks Yet";
    _picView.alpha = 0;
}

@end
