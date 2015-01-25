//
//  ViewController.m
//  ActionCameraDemo
//
//  Created by  吕欣韵 on 2015-01-09.
//  Copyright (c) 2015 UofT. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *latLabel;
@property (weak, nonatomic) IBOutlet UILabel *lonLabel;
@property BOOL isShacken;
@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
// Live Image Part
#pragma mark - live image
        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        session.sessionPreset = AVCaptureSessionPresetMedium;
        
        CALayer *viewLayer = self.cameraView.layer;
        NSLog(@"viewLayer = %@", viewLayer);
        
        AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
        
        captureVideoPreviewLayer.frame = self.cameraView.bounds;
        [self.cameraView.layer addSublayer:captureVideoPreviewLayer];
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (!input) {
            // Handle the error appropriately.
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
    
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:_stillImageOutput];
        
    [session startRunning];
//  Live image Part End
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#pragma mark - init location manager
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;

    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"myData.plist"];
    NSString *localPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"localData.plist"];
    
    NSArray *nameTemp = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSArray *localTemp = [[NSArray alloc] initWithContentsOfFile:localPath];
    
    _nameArray = [[NSMutableArray alloc] init];
    _localArray = [[NSMutableArray alloc] init];
    
    [_nameArray addObjectsFromArray:nameTemp];
    [_localArray addObjectsFromArray:localTemp];
    
    self.isShacken = NO;
}

#pragma mark - viberation feedback
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        // Put in code here to handle shake
// startUpdatingLocation
        if ([CLLocationManager locationServicesEnabled]) {
            [self.locationManager startUpdatingLocation];
        }
        else {
            NSLog(@"请开启定位功能！");
        }
#pragma mark - call of picture action
        [self performSelector:@selector(pictureAction) withObject:nil afterDelay:1.0f];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pictureAction {
    NSLog(@"Your iPhone is Shaking!!!");
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in _stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    NSLog(@"about to request a capture from: %@", _stillImageOutput);
    [_stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         }
         else
             NSLog(@"no attachments");
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];

//---------------------Get the Current Time as Uique Name---------------------------------------------
         NSDate *date = [NSDate date];
         NSCalendar *calendar = [NSCalendar currentCalendar];
         NSDateComponents *comps;
         comps = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
         
         NSInteger hour = [comps hour];
         NSInteger min = [comps minute];
         NSInteger sec = [comps second];
         
         NSString *uiqueName = [NSString stringWithFormat:@"%ld%ld%ld", (long)hour, (long)min, (long)sec];
         NSLog(@"uique: %@", uiqueName);
         [_nameArray addObject:uiqueName];
         NSLog(@"%@", _nameArray);
//---------------------Get the Current Time as Uique Name---------------------------------------------
         
         
         
         
//-------------------------- Save image to sandbox --------------------------------------------------
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
         NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", uiqueName]];
         [UIImagePNGRepresentation(image)writeToFile:filePath atomically:YES];
         
         NSString *newName = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"myData.plist"];
         [_nameArray writeToFile:newName atomically:YES];
         
//-------------------------- Save image to sandbox --------------------------------------------------

         
         
// get image from live preview
         self.vImage.image = image;
     }];

}


//static int i = 0;
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    if (self.isShacken == NO) {
        CLLocation *currentLocation = [locations lastObject];
        
        CLLocationCoordinate2D coor = currentLocation.coordinate;
        NSLog(@"%f", coor.latitude);
        NSLog(@"%f", coor.longitude);
        
        NSString *localStr = [NSString stringWithFormat:@"(%f,%f)", coor.longitude, coor.latitude];
//        NSString *localStr = [NSString stringWithFormat:@"0101"];
//        i++;

        
        [_localArray addObject:localStr];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *localPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"localData.plist"];
        [_localArray writeToFile:localPath atomically:YES];
        
        
        self.latLabel.text = [NSString stringWithFormat:@"%.3f", coor.latitude];
        self.lonLabel.text = [NSString stringWithFormat:@"%.3f", coor.longitude];
        self.isShacken = YES;
        [self performSelector:@selector(changeBool) withObject:self afterDelay:0.1];
    }
    
    
    
    //[self.locationManager stopUpdatingLocation];
    
}
// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)changeBool{
    self.isShacken = NO;
}

@end
