//
//  CatagroyButton.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CatagroyButton.h"

@implementation CatagroyButton

-(instancetype)initWithFrame:(CGRect)frame{

    if(self=[super initWithFrame:frame]){
//        self.imageEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
//        self.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
//        self.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

-(void)setCategory:(NSString *)category {

    _category =category;

}
-(void)setNTag:(NSInteger )nTag{

    _nTag=nTag;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
