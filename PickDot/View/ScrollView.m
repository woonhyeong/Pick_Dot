//
//  ScrollView.m
//  PickDot
//
//  Created by 이운형 on 17/11/2018.
//  Copyright © 2018 201302458. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView

-(id)init {
    self = [super init];
    if(self){
        [self.layer setBorderWidth:0.5f];
        [self.layer setBorderColor:[UIColor blackColor].CGColor];
        self.minimumZoomScale = 0.5f;
        self.maximumZoomScale = 2.0f;
    }
    return self;
}

@end
