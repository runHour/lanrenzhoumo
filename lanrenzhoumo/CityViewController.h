//
//  CityViewController.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/10/28.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityTableViewCell.h"

@protocol CityTableViewDelegate <NSObject>
//把按钮的相关信息通过字典的方式传给VC
-(void)sendSelectCityMasage:(NSDictionary*)dic;

@end

@interface CityViewController : UIViewController
@property(nonatomic,assign)id<CityTableViewDelegate>delegate;
@property(nonatomic,strong)NSString *currentCity;
@property(nonatomic,strong)NSDictionary *currentCityDic;//当前定位城市信息字典

@end
