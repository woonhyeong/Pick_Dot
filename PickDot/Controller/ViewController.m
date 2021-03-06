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
@property (weak, nonatomic) IBOutlet UIView *contrastView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *directionImage;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *penTimer;
@property (strong, nonatomic) NSTimer *eraserTimer;
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

    /*
     ScrollView initiation
     */
    self.scrollView.delegate = self;
    [self.scrollView.layer setBorderWidth:0.5f];
    [self.scrollView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.scrollView addSubview:self.contentView];
    self.scrollView.minimumZoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height);
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setBounces:NO];
    [self.scrollView setBouncesZoom:NO];

    /*
     Press Gesture to Direction Button
     */
    UILongPressGestureRecognizer *leftPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidLeftPress:)];
    [self.leftButton addGestureRecognizer:leftPress];
    UILongPressGestureRecognizer *rightPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidRightPress:)];
    [self.rightButton addGestureRecognizer:rightPress];
    UILongPressGestureRecognizer *upPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidUpPress:)];
    [self.upButton addGestureRecognizer:upPress];
    UILongPressGestureRecognizer *downPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidDownPress:)];
    [self.downButton addGestureRecognizer:downPress];
    
    /*
     Press Gesture to Pen Button & Eraser Button
     */
     UILongPressGestureRecognizer *penPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidPenPress:)];
    [self.buttonPen addGestureRecognizer:penPress];
    UILongPressGestureRecognizer *eraserPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidEraserPress:)];
    [self.buttonEraser addGestureRecognizer:eraserPress];
    
    [self.view addSubview:self.colorPickerView];
    [self loadTableViewController];
}

#pragma mark - UILongPressGestureRecognizer methods
- (void)buttonDidLeftPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(leftPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.timer invalidate];
            self.timer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)buttonDidRightPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(rightPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.timer invalidate];
            self.timer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)buttonDidUpPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(upPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.timer invalidate];
            self.timer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)buttonDidDownPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(downPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.timer invalidate];
            self.timer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)buttonDidPenPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.penTimer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(penPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.penTimer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.penTimer invalidate];
            self.penTimer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)buttonDidEraserPress:(UILongPressGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.eraserTimer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(eraserPress)userInfo:nil repeats:YES];
            NSRunLoop * theRunLoop = [NSRunLoop currentRunLoop];
            [theRunLoop addTimer:self.eraserTimer forMode:NSDefaultRunLoopMode];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.eraserTimer invalidate];
            self.eraserTimer = nil;
        }
            break;
        default:
            break;
    }
}
- (void)rightPress{
    [self.contentView moveSelectedPixelAtIndex:Right];
}
- (void)leftPress{
    [self.contentView moveSelectedPixelAtIndex:Left];
}
- (void)upPress{
    [self.contentView moveSelectedPixelAtIndex:Up];
}
- (void)downPress{
    [self.contentView moveSelectedPixelAtIndex:Down];
}
- (void)penPress{
    [self.contentView setSelectedColor:self.selectedColor];
    [self.contentView drawColorToPixel];
}
- (void)eraserPress{
    [self.contentView setSelectedColor:[UIColor whiteColor]];
    [self.contentView drawColorToPixel];
}

#pragma mark - ScrollView Delegate methods
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
        [self.colorPickerView.layer setCornerRadius:5];
        [self.colorPickerView.layer setBorderWidth:0.5f];
        [self.colorPickerView.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.colorPickerView setHidden:YES];
        [self.colorPickerView setBackgroundColor:[UIColor whiteColor]];
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
    if(self.scrollView.frame.size.width > self.scrollView.frame.size.height){
        CGFloat originY = (self.backView.frame.size.height - self.scrollView.frame.size.width);
        [self.backView setFrame:CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y - originY, self.backView.frame.size.width, self.backView.frame.size.height+originY)];
        [self.scrollView setFrame:CGRectMake(self.scrollView.frame.origin.x, self.backView.frame.origin.y+originY, self.scrollView.frame.size.width, self.scrollView.frame.size.width)];
    }
    
    [self.selectedColorLabel.layer setBorderWidth:1.0f];
    [self.selectedColorLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.selectedColorLabel.layer setCornerRadius:0.5 * self.selectedColorLabel.bounds.size.width];
    [self.selectedColorLabel setBackgroundColor:[UIColor clearColor]];
    self.selectedColor = [UIColor whiteColor];
    
    [self.scrollView setBackgroundColor:[UIColor whiteColor]];
    [self.scrollView.layer setCornerRadius:5];
    [self.backView.layer setCornerRadius:20];
    [self.contrastView.layer setCornerRadius:20];
    
    CGFloat x  = self.directionImage.frame.size.width/3;
    CGFloat y  = self.directionImage.frame.size.height/3;
    
    [self.upButton setFrame:CGRectMake(self.directionImage.frame.origin.x+x, self.directionImage.frame.origin.y, x, y)];
    [self.leftButton setFrame:CGRectMake(self.directionImage.frame.origin.x
                                         ,self.directionImage.frame.origin.y+y
                                         , x, y)];
    [self.rightButton setFrame:CGRectMake(self.directionImage.frame.origin.x+2*x, self.directionImage.frame.origin.y+y, x, y)];
    [self.downButton setFrame:CGRectMake(self.directionImage.frame.origin.x+x, self.directionImage.frame.origin.y+2*y, x, y)];
    
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

-(void)exportPixelToJPEG {
    [self.contentView prevScreenShotPixel];
    
    UIGraphicsBeginImageContextWithOptions(self.contentView.bounds.size,NO, 0.0);
    [self.contentView drawViewHierarchyInRect:self.contentView.bounds afterScreenUpdates:YES];
    UIImage * snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *pngData = UIImagePNGRepresentation(snapshotImage);
    snapshotImage = [UIImage imageWithData:pngData];
    UIImageWriteToSavedPhotosAlbum(snapshotImage, self, nil, nil );
    
    [self.contentView afterScreenShotPixel];
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
        self->_saveSelectVC.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        [UIView animateWithDuration:0.5 animations:^{
            self->_saveSelectVC.view.alpha = 1;
            self->_saveSelectVC.view.transform = CGAffineTransformMakeScale(1, 1);
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
        self->_areaSelectVC.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        [UIView animateWithDuration:0.5 animations:^{
            self->_areaSelectVC.view.alpha = 1;
            self->_areaSelectVC.view.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}

- (void)selectLoadCell {
    [self loadOpenTableViewController];
}

- (void)selectExportCell {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Export"
                                 message:@"Are You Sure Want to Export Pixel to JPEG!"
                                 preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self exportPixelToJPEG];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
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
    
    if((16+4*matrixSize)*20 < self.scrollView.frame.size.width){
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }else{
        self.scrollView.contentSize = CGSizeMake((16+4*matrixSize)*20,(16+4*matrixSize)*20 );
    }
    self.scrollView.minimumZoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    
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
    
    NSInteger matrixSize = [[jsonDic objectForKey:@"Size"]integerValue];
    self.scrollView.zoomScale = 1;
    [self.contentView LoadPrevPixelView:jsonDic];
    
    self.scrollView.zoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    if(matrixSize*20 < self.scrollView.frame.size.width){
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }else{
        self.scrollView.contentSize = CGSizeMake((matrixSize)*20,(matrixSize)*20 );
    }
    self.scrollView.minimumZoomScale = self.scrollView.frame.size.width/self.contentView.bounds.size.width;
    [self.menuViewController.view setHidden:YES];
    [self.scrollView setHidden:NO];
}

#pragma mark - Rotation Control methods
-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end

