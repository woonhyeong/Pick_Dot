//
//  ViewController.m
//  Pick_Dot
//
//  Created by 이운형 on 15/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ViewController.h"
#import "PixelView.h"
#import "NKOColorPickerView.h"

@interface ViewController ()
@property (weak,nonatomic) IBOutlet UILabel *selectedColor;
@property (nonatomic) NKOColorPickerView *colorPickerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUI];
    
    [self.contentView setFrame:CGRectMake(0, 0, 400, 400)];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.contentSize = self.contentView.bounds.size;
    [self.scrollView.layer setBorderWidth:0.5f];
    [self.scrollView.layer setBorderColor:[UIColor blackColor].CGColor];
    self.scrollView.minimumZoomScale = 0.5f;
    self.scrollView.maximumZoomScale = 2.0f;
    
    [self.view addSubview:self.colorPickerView];
}

-(IBAction)buttontouch:(UIButton *)sender
{
    if ([[sender superview] isKindOfClass:[PixelView class]]) {
        NSLog(@"Button Index: %ld", ((PixelView*)[sender superview]).index);
    }
    [self.contentView selectPixelAtIndex:((PixelView*)[sender superview]).index];
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

-(NKOColorPickerView *)colorPickerView {
    if (_colorPickerView == nil) {
        NKOColorPickerDidChangeColorBlock colorDidChangeBlock = ^(UIColor *color){
            [self changeColorAction:color];
        };
        _colorPickerView = [[NKOColorPickerView alloc]initWithFrame:self.scrollView.frame color:[UIColor colorWithRed:0.329f green:0.718f blue:1.f alpha:1.f] andDidChangeColorBlock:colorDidChangeBlock];
        
        [self.colorPickerView setTintColor:[UIColor darkGrayColor]];
        [self.colorPickerView.layer setBorderWidth:0.5f];
        [self.colorPickerView.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.colorPickerView setHidden:YES];
    }
    return _colorPickerView;
}

#pragma mark - IBAction Methods
- (IBAction)menuButtonTouched:(UIButton *)sender {
}

- (IBAction)colorButtonTouched:(UIButton *)sender {
    if ([self.colorPickerView isHidden]) {
        [self.scrollView setHidden:YES];
        [self.colorPickerView setHidden:NO];
    } else {
        [self.scrollView setHidden:NO];
        [self.colorPickerView setHidden:YES];
    }
}

#pragma mark - Priavate Methods
- (void)makeUI {
    [self.selectedColor.layer setBorderWidth:1.0f];
    [self.selectedColor.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.selectedColor.layer setCornerRadius:0.5 * self.selectedColor.bounds.size.width];
    [self.selectedColor setBackgroundColor:[UIColor clearColor]];
}

-(void)changeColorAction:(UIColor *)color{
    [self.selectedColor.layer setBackgroundColor:self.colorPickerView.color.CGColor];
}

#pragma mark - Delegate Methods
- (void) pixelTouched : (PixelView *)requestor {
    NSLog(@"%li",requestor.index);
}

@end

