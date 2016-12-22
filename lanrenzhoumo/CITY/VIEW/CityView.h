//
//  CityView.h
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CityView : UIView
@property (nonatomic , copy) NSString              * province_name;
@property (nonatomic , copy) NSString              * city_name;
@property (nonatomic , strong) NSNumber            * city_id;
@property (nonatomic , strong) NSNumber            * province_id;
@property (nonatomic , copy) NSString              * currentCityName;
@property(nonatomic,strong)UIButton                *selectedButton;

-(void)setModel:(id)model;
-(instancetype)initWithFrame:(CGRect)frame fromModel:(NSArray*)model andJudge:(NSInteger)num;//通过数字判断创建方法
-(void)creatHotCity:(NSArray*)model;
-(void)creatCurrentBtnFromModel:(id)model;
@end
