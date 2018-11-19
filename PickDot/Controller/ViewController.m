//
//  ViewController.m
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ViewController.h"
<<<<<<< HEAD:PickDot/Controller/ViewController.m
<<<<<<< HEAD:PickDot/Controller/ViewController.m
#import "PixelView.h"
=======
>>>>>>> parent of d1a95c2... [added tap action pixelView]:PickDot/ViewController.m
=======
>>>>>>> parent of d1a95c2... [added tap action pixelView]:PickDot/ViewController.m

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Delegate Methods
-(void) pixelTouched : (PixelView *)requestor {
    NSLog(@"Tap Test");
}
@end

