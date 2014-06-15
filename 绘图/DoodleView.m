//
//  DoodleView.m
//  绘图
//
//  Created by lanou3g on 14-6-15.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView
- (void)dealloc
{
    RELESAE_SAFELY(_lineArray);
    [super dealloc];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //记录所有线的数组
        self.lineArray = [NSMutableArray arrayWithCapacity:1];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        NSLog(@"%@",NSStringFromCGRect(frame));
        button.frame = CGRectMake((frame.size.width -100)/2 , frame.size.height - 50, 100, 30);
        [button setTitle:@"undo" forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}
//按钮
- (void)undo:(UIButton *)button
{
   
    [_lineArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
}
//重写绘图方法，当view修改frame的时候会被调用
- (void)drawRect:(CGRect)rect
{
    //CGContextRef只能通过2种方式拿到上下文:1.在drawRect拿到上下文,2.通过一个image图片拿到上下文
    //得到上下文，配置绘图信息，
    CGContextRef context = UIGraphicsGetCurrentContext();
  //设置绘画颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置画笔粗细
    CGContextSetLineWidth(context, 2.0);
    //拿到每一笔小数组
    for (int i = 0; i < [_lineArray count]; i++) {
        NSMutableArray * pointArray = [_lineArray objectAtIndex:i];
        //???:count 返回NSInterger类型,-1,如果是负数,就返回一个无穷大的数,所以要转换类型
        for (int j = 0; j < (int)pointArray.count - 1; j++) {
            NSValue * firstPointValue = [pointArray objectAtIndex:j];
            NSValue * secondPointValue = [pointArray objectAtIndex:j + 1];
            //返回CGPoint对象
            CGPoint firstPoint = [firstPointValue CGPointValue];
            CGPoint secondPoint = [secondPointValue CGPointValue];
            //把笔触移动一个点
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            //笔触和另一个点要成一个路径
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
        }
        //绘制
        CGContextStrokePath(context);
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //记录所有点得数组
    NSMutableArray * pointArray = [NSMutableArray arrayWithCapacity:1];
    [_lineArray addObject:pointArray];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //取出触摸
    UITouch * touch = [touches anyObject];
    //取出触摸点
    CGPoint point = [touch locationInView:self];
    NSLog(@"point %@",NSStringFromCGPoint(point));
    //取出线数组中最后一个数组
    NSMutableArray * pointArray = [_lineArray lastObject];
    //把CGPoint转换为对象类型
    NSValue * pointValue = [NSValue valueWithCGPoint:point];
    //将point转换后的pointValue加入数组
    [pointArray addObject:pointValue];
    //重绘界面
    [self setNeedsDisplay];
}
@end
