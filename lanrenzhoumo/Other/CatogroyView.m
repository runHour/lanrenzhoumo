//
//  CatogroyView.m
//  lanrenzhoumo
//
//  Created by Ibokan on 2016/11/2.
//  Copyright © 2016年 fuyuzheng. All rights reserved.
//

#import "CatogroyView.h"
#import "CatagroyButton.h"

#define Width self.frame.size.width
#define Height self.frame.size.height
#define padding  20
#define topPadding 10
#define btnWidth (Width-5*padding)/3
@implementation CatogroyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.frame=frame;
        self.layer.masksToBounds=YES;
        self.image=[UIImage imageNamed:@"backImg4"];
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=10;
    }

    return self;
}


-(void)setCatogroyBtn{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"catogroyList" ofType:@"plist"];
    NSArray *list=[NSArray arrayWithContentsOfFile:path];
    NSArray *common=list[0];
    int  num=0;
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            NSString *name=[common[num] valueForKey:@"name"];
            NSString *img=[common[num] valueForKey:@"img"];
            NSString *category=[common[num] valueForKey:@"category_id"];
            CatagroyButton *btn=[[[NSBundle mainBundle]loadNibNamed:@"newBtn" owner:nil options:nil]objectAtIndex:0];
            
            btn.frame=CGRectMake(Width, 0, btnWidth, 30);
            [UIView animateWithDuration:0.5 animations:^{
                ///
                btn.frame=CGRectMake(20+padding+(btnWidth+padding)*j, topPadding+(topPadding+30)*i, btnWidth, 30);
            }];
            btn.contentLabel.text=name;
            btn.categroyName=name;
            btn.leftimg.image=[UIImage imageNamed:img];
            [btn addTarget:self action:@selector(selcectAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.category=category;
            btn.nTag=400+num;
            [self addSubview:btn];//
            num++;
        }
    }
}
//声明协议
-(void)selcectAction:(CatagroyButton*)sender{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectCatogroyByButton:)]) {
        [self.delegate selectCatogroyByButton:sender];
    }
}



@end
