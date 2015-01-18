//
//  ViewController.h
//  ActionCameraDemo
//
//  Created by  吕欣韵 on 2015-01-09.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (retain, nonatomic) IBOutlet UIImageView *vImage;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

