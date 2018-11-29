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
    
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 10.0;
    self.scrollView.contentSize = self.contentView.frame.size;
    [self.scrollView addSubview:self.contentView];
    [self.scrollView.layer setBorderWidth:0.5f];
    [self.scrollView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    [self.view addSubview:self.colorPickerView];
    [self loadTableViewController];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.contentView;
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
    if ([self.menuViewController.view isHidden]) {
        [self.scrollView setHidden:YES];
        [self.menuViewController.view setHidden:NO];
        [self.colorPickerView setHidden:YES];
    } else {
        [self.scrollView setHidden:NO];
        [self.menuViewController.view setHidden:YES];
        [self.colorPickerView setHidden:YES];
    }
}

- (IBAction)colorButtonTouched:(UIButton *)sender {
    if ([self.colorPickerView isHidden]) {
        [self.scrollView setHidden:YES];
        [self.menuViewController.view setHidden:YES];
        [self.colorPickerView setHidden:NO];
    } else {
        [self.scrollView setHidden:NO];
        [self.menuViewController.view setHidden:YES];
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
    [self.contentView setSelectedColor:self.selectedColor];
    [self.contentView drawColorToPixel];
}

- (IBAction)eraserButtonTouched:(UIButton *)sender {
    [self.contentView setSelectedColor:[UIColor clearColor]];
    [self.contentView drawColorToPixel];
}

- (IBAction)arrowButtonTouched:(UIButton *)sender {
    NSString* buttonTitle = sender.titleLabel.text;
    
    if ([buttonTitle isEqualToString:@"left"]) {
        [self.contentView moveSelectedPixelAtIndex:Left];
    } else if ([buttonTitle isEqualToString:@"right"]){
        [self.contentView moveSelectedPixelAtIndex:Right];
    } else if ([buttonTitle isEqualToString:@"up"]){
        [self.contentView moveSelectedPixelAtIndex:Up];
    } else if ([buttonTitle isEqualToString:@"down"]){
        [self.contentView moveSelectedPixelAtIndex:Down];
    }
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

-(void)loadTableViewController {
    _menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];
    _menuViewController.delegate = self;
    [_menuViewController.view setFrame:self.scrollView.frame];
    [self addChildViewController:_menuViewController];
    [self.view addSubview:_menuViewController.view];
    [_menuViewController didMoveToParentViewController:self];
    
}

#pragma mark - Delegate Methods
- (void)selectSaveCell {
    NSLog(@"SAVE");
}

- (void)selectNewCell {
    _areaSelectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"areaSelectVC"];
    _areaSelectVC.delegate = self;
    _areaSelectVC.providesPresentationContextTransitionStyle = YES;
    _areaSelectVC.definesPresentationContext = YES;
    [_areaSelectVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self presentViewController:_areaSelectVC animated:NO completion:^{
        self->_areaSelectVC.view.alpha = 0;

        [UIView animateWithDuration:0.5 animations:^{
            self->_areaSelectVC.view.alpha = 1;
        }];
    }];
}

- (void)selectOpenCell {
    NSLog(@"OPEN");
}

- (void)dismiss:(NSInteger)matrixSize {
    [self.areaSelectVC dismissViewControllerAnimated:NO completion:nil];
    NSLog(@"%ld",matrixSize);
}
@end

