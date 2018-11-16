//
//  ViewController.m
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ViewController.h"
#import "PixelView.h"
@interface ViewController ()
@property (nonatomic, weak) IBOutlet PixelView * basedPixelView;
@end

@implementation ViewController

-(IBAction)buttontouch:(UIButton *)sender
{
    NSLog(@"Button TAG: %ld", sender.tag);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.basedPixelView.vcDelegate =self;
}

#pragma mark - Delegate Methods
-(void) pixelTouched : (PixelView *)requestor {
    
}
@end

