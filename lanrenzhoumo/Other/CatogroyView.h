//
//  CatogroyView.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CatagroyButton;
@protocol CatogroyViewDelegate <NSObject>

-(void)selectCatogroyByButton:(CatagroyButton*)btn;

@end
@interface CatogroyView : UIImageView
@property(nonatomic,assign)id<CatogroyViewDelegate>delegate;
@property(nonatomic,strong)UIImageView *imgView;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setCatogroyBtn;
@end
