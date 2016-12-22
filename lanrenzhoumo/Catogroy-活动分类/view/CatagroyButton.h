//
//  CatagroyButton.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatagroyButton : UIButton
@property(nonatomic,assign)NSString *category;//分区
@property(nonatomic,assign)NSInteger  nTag;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftimg;
@property(nonatomic,strong)NSString *categroyName;

@end
