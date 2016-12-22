//
//  CityView.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CityView.h"
#import "CityModel.h"
#import "CityButton.h"
#import "CurrCityButton.h"
#define Width    [UIScreen mainScreen].bounds.size.width
#define Height   [UIScreen mainScreen].bounds.size.height
#define BtnWidth   (Width-LEFTPadding)/6
#define LEFTPadding   20
#define BtnHeight 30
@implementation CityView

-(void)setModel:(CityModel*)model{
    self.province_id=model.province_id;
    self.province_name=model.province_name;
    self.city_id=model.city_id;
    self.city_name=model.city_name;
    
}
-(instancetype)initWithFrame:(CGRect)frame fromModel:(NSArray*)model andJudge:(NSInteger)num{
    self.userInteractionEnabled=YES;
    if (self=[super initWithFrame:frame]) {
        switch (num) {
            case 0:
                break;
            case 1:
                [self creatHotCity:model];
                break;
            default:
                break;
        }
    }

    return self;
}

-(void)creatCurrentBtnFromModel:(NSMutableDictionary*)currCityDic{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(LEFTPadding, 5, 100, 30)];
    label.text=@"当前位置";
    label.font=[UIFont systemFontOfSize:17];
    [self addSubview:label];
    CurrCityButton *btn=[[CurrCityButton alloc]initWithFrame:CGRectMake(LEFTPadding+BtnWidth*2*2-20, 5, BtnWidth+30, BtnHeight) fromDictionary:currCityDic];
//     btn.titleLabel.textAlignment=NSTextAlignmentLeft;
    
    NSString *cityName=currCityDic[@"cityName"];
    
    if (cityName==nil) {
     [btn setTitle:@"未知" forState:UIControlStateNormal];
        
    }
    else{
        [btn setTitle:cityName forState:UIControlStateNormal];        
    }
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     btn.userInteractionEnabled=YES;
    btn.titleLabel.font=[UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(currCityAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

}

-(void)creatHotCity:(NSArray*)model{
    int num=0;
    for (int i=0; i<5; i++) {
        for (int j=0; j<3; j++) {
            CityButton *btn=[[CityButton alloc]initWithFrame:CGRectMake(LEFTPadding+BtnWidth*j*2, LEFTPadding+(LEFTPadding+BtnHeight)*i, BtnWidth, BtnHeight)fromModel:model[num]];
            [btn setTitle:btn.city_name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font=[UIFont systemFontOfSize:20];
            btn.tag=200+num;
            btn.backgroundColor=[UIColor whiteColor];
           
            [btn addTarget:self action:@selector(selectedCity:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            num++;
        }
    }

}
//点击事件
-(void)selectedCity:(CityButton*)sender{
   
    NSDictionary *dic=@{@"city_name":sender.city_name,@"city_id":sender.city_id};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectBtn" object:self userInfo:dic];

}

-(void)currCityAciton:(CurrCityButton*)btn{
    NSDictionary *dic=btn.dic;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"selectCurrBtn" object:self userInfo:dic];




}


















@end
