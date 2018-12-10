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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"count"] == nil) {
        [userDefaults setInteger:0 forKey:@"count"];
    }
    
    if ([userDefaults objectForKey:@"files"] == nil) {
        NSMutableArray *dic = [[NSMutableArray alloc]init];
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        
        NSString *requestJson = [[NSString alloc] initWithData:requestData
                                                      encoding:NSUTF8StringEncoding];
        [userDefaults setObject:requestJson forKey:@"files"];
    }

    self.scrollView.delegate = self;
    [self.scrollView.layer setBorderWidth:0.5f];
    [self.scrollView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.frame.size.width;
    self.scrollView.contentSize = CGSizeMake(500, 500);
    
    
    UIPinchGestureRecognizer *twoFingerPinch = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(twoFingerPinch:)];
    [self.view addGestureRecognizer:twoFingerPinch];

    [self.view addSubview:self.colorPickerView];
    [self loadTableViewController];
}

- (void)twoFingerPinch:(UIPinchGestureRecognizer *)recognizer
{
    if(recognizer.scale < 0.5)
        [recognizer setScale:0.5];
    if(recognizer.scale > 5.0)
       [recognizer setScale:5.0];
    CGAffineTransform transform = CGAffineTransformMakeScale(recognizer.scale, recognizer.scale);
    self.contentView.transform = transform;
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
        
        [self.buttonPen setEnabled:NO];
        [self.buttonEraser setEnabled:NO];
    } else {
        [self.scrollView setHidden:NO];
        [self.menuViewController.view setHidden:YES];
        [self.colorPickerView setHidden:YES];
        
        [self.buttonPen setEnabled:YES];
        [self.buttonEraser setEnabled:YES];
    }
    
    [self closeOpenTableViewController];
}

- (IBAction)colorButtonTouched:(UIButton *)sender {
    if ([self.colorPickerView isHidden]) {
        [self.scrollView setHidden:YES];
        [self.menuViewController.view setHidden:YES];
        [self.colorPickerView setHidden:NO];
        
        [self.buttonPen setEnabled:NO];
        [self.buttonEraser setEnabled:NO];
    } else {
        [self.scrollView setHidden:NO];
        [self.menuViewController.view setHidden:YES];
        [self.colorPickerView setHidden:YES];
        
        [self.buttonPen setEnabled:YES];
        [self.buttonEraser setEnabled:YES];
    }
    
    [self closeOpenTableViewController];
}

-(IBAction)pixelTouch:(UIButton *)sender
{
    if ([[sender superview] isKindOfClass:[PixelView class]]) {
        [self.contentView selectPixelAtIndex:((PixelView*)[sender superview]).index];
    }
}

- (IBAction)penButtonTouched:(UIButton *)sender {
    [self.contentView setSelectedColor:self.selectedColor];
    [self.contentView drawColorToPixel];
}

- (IBAction)eraserButtonTouched:(UIButton *)sender {
    [self.contentView setSelectedColor:[UIColor whiteColor]];
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
    self.selectedColor = [UIColor whiteColor];
}

- (void)changeColorAction:(UIColor *)color{
    [self.selectedColorLabel.layer setBackgroundColor:self.colorPickerView.color.CGColor];
    [self.contentView setSelectedColor:self.colorPickerView.color];
    self.selectedColor = color;
}

- (void)loadTableViewController {
    if (_menuViewController == nil) {
        _menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];
        _menuViewController.delegate = self;
        [_menuViewController.view setFrame:self.scrollView.frame];
        [self addChildViewController:_menuViewController];
        [self.view addSubview:_menuViewController.view];
        [_menuViewController didMoveToParentViewController:self];
    }
}

- (void)loadOpenTableViewController {
    if (_openViewController == nil) {
        _openViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"openVC"];
        _openViewController.delegate = self;
        [_openViewController.view setFrame:self.scrollView.frame];
        [self addChildViewController:_openViewController];
        [self.view addSubview:_openViewController.view];
        [_openViewController didMoveToParentViewController:self];
        
        [self.buttonPen setEnabled:NO];
        [self.buttonEraser setEnabled:NO];
    }
}

- (void)closeOpenTableViewController {
    if([[self childViewControllers]containsObject:self.openViewController]){
        [self.openViewController removeFromParentViewController];
        [self.view.subviews.lastObject removeFromSuperview];
        
        [self.buttonPen setEnabled:YES];
        [self.buttonEraser setEnabled:YES];
    }
}
#pragma mark - Delegate Methods
- (void)selectSaveCell {
    _saveSelectVC = [self.storyboard instantiateViewControllerWithIdentifier:@"saveSelecrtVC"];
    _saveSelectVC.delegate = self;
    _saveSelectVC.providesPresentationContextTransitionStyle = YES;
    _saveSelectVC.definesPresentationContext = YES;
    [_saveSelectVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self presentViewController:_saveSelectVC animated:NO completion:^{
        self->_saveSelectVC.view.alpha = 0;
        
        [UIView animateWithDuration:0.5 animations:^{
            self->_saveSelectVC.view.alpha = 1;
        }];
    }];
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

- (void)selectLoadCell {
    [self loadOpenTableViewController];
}

- (void)dismiss:(NSInteger)matrixSize {
    /*
     matrixSize
     0 : 16     1 : 20      2 : 24      3 : 28
     */
    
    /*
     Make new contentView
     */
    self.scrollView.zoomScale = 1;
    [self.contentView setMatrixSize:(16+4*matrixSize)];
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.frame.size.width;
    self.scrollView.contentSize = CGSizeMake((16+4*matrixSize)*20,(16+4*matrixSize)*20 );
    
    
    [self.menuViewController.view setHidden:YES];
    [self.scrollView setHidden:NO];
    
    [self.areaSelectVC dismissViewControllerAnimated:NO completion:nil];
    [self.buttonPen setEnabled:YES];
    [self.buttonEraser setEnabled:YES];
}

- (void)saveFile:(NSString *)fileTitle {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* dic = [[NSDictionary alloc]initWithDictionary:self.contentView.pixelArrayConvertedToDictionary];
    
    NSError* err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic                                                           options:NSJSONWritingPrettyPrinted error:&err];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", err);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [userDefaults setObject:jsonString forKey:fileTitle];
        
        NSInteger i = [userDefaults integerForKey:@"count"];
        [userDefaults setInteger:(i+1) forKey:@"count"];
        
        NSString *requestString = [userDefaults objectForKey:@"files"];
        NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *requestArray = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
        [requestArray addObject:fileTitle];
        requestData = [NSJSONSerialization dataWithJSONObject:requestArray options:NSJSONWritingPrettyPrinted error:nil];
        jsonString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        [userDefaults setObject:jsonString forKey:@"files"];
    }
    
    [self.saveSelectVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadPixelFromJsonData:(NSString*)jsonKey{
    [self closeOpenTableViewController];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *requestString = [userDefaults objectForKey:jsonKey];
    NSData *requestData = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableContainers error:nil];
    
    self.scrollView.zoomScale = 1;
    [self.contentView LoadPrevPixelView:jsonDic];
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.frame.size.width;
    self.scrollView.contentSize = self.contentView.frame.size;
    [self.menuViewController.view setHidden:YES];
    [self.scrollView setHidden:NO];
}
@end

