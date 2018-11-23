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
@property (weak, nonatomic) IBOutlet PixelView* pixel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pixel.vcDelegate = self;
    [self.contentView setFrame:CGRectMake(0, 0, 400, 400)];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.bounds.size;
}

-(IBAction)buttontouch:(UIButton *)sender
{
    if ([[sender superview] isKindOfClass:[PixelView class]]) {
        NSLog(@"Button Index: %ld", ((PixelView*)[sender superview]).index);
    }
}

#pragma mark - Getter & Setter
-(ContentView *)contentView {
    if (_contentView == nil) {
        _contentView = [[ContentView alloc]init];
    }
    return _contentView;
}

-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}
#pragma mark - Delegate Methods
-(void) pixelTouched : (PixelView *)requestor {
    NSLog(@"%li",requestor.index);
}

@end

