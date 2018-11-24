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
@property (nonatomic) IBOutlet ContentView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *selectedColorLabel;
@property (weak, nonatomic) UIColor* selectedColor;
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

#pragma mark - Getter & Setter
-(ContentView *)contentView {
    if (_contentView == nil) {
        _contentView = [[ContentView alloc]init];
    }
    return _contentView;
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

-(IBAction)pixelTouch:(UIButton *)sender
{
    if ([[sender superview] isKindOfClass:[PixelView class]]) {
        NSLog(@"Button Index: %ld", ((PixelView*)[sender superview]).index);
        [self.contentView selectPixelAtIndex:((PixelView*)[sender superview]).index];
    }
}

- (IBAction)penButtonTouched:(UIButton *)sender {
    [self.contentView drawColorToPixel:self.selectedColor];
}

- (IBAction)eraserButtonTouched:(UIButton *)sender {
}
#pragma mark - Priavate Methods
- (void)makeUI {
    [self.selectedColorLabel.layer setBorderWidth:1.0f];
    [self.selectedColorLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.selectedColorLabel.layer setCornerRadius:0.5 * self.selectedColorLabel.bounds.size.width];
    [self.selectedColorLabel setBackgroundColor:[UIColor clearColor]];
    self.selectedColor = [UIColor clearColor];
}

-(void)changeColorAction:(UIColor *)color{
    [self.selectedColorLabel.layer setBackgroundColor:self.colorPickerView.color.CGColor];
    [self.contentView setSelectedColor:self.colorPickerView.color];
    self.selectedColor = color;
}

#pragma mark - Delegate Methods
- (void) pixelTouched : (PixelView *)requestor {
    NSLog(@"%li",requestor.index);
}

@end

