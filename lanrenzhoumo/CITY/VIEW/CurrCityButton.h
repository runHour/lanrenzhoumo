//
//  CurrCityButton.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/9.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrCityButton : UIButton
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,assign)CGFloat   latitude;
@property(nonatomic,assign)CGFloat   longitude;
@property(nonatomic,strong)NSMutableDictionary *dic;
-(instancetype)initWithFrame:(CGRect)frame fromDictionary:(NSDictionary *)dic;
@end
