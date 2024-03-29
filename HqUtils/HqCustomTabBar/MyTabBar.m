#import "MyTabBar.h"
#import "UIView+Extension.h"
#define centerButtonMargin 10

@interface MyTabBar()

//指向中间“+”按钮
@property (nonatomic,weak) UIButton *centerButton;
//指向“添加”标签
@property (nonatomic,weak) UILabel *centerLabel;

@end

@implementation MyTabBar


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundImage = [UIImage new];
        self.shadowImage = [UIImage new];
        self.backgroundColor = [UIColor whiteColor];
        
        //tabbar_add_yellow
        //创建中间“+”按钮
        UIImage *centerBtnImage = [UIImage imageNamed:@"lc_tab_mining_selected_icon"];
        UIButton *addBtn = [[UIButton alloc] init];
        //设置默认背景图片
        [addBtn setBackgroundImage:centerBtnImage forState:UIControlStateNormal];
        //设置按下时背景图片
        [addBtn setBackgroundImage:centerBtnImage forState:UIControlStateHighlighted];
        //添加响应事件
        [addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        addBtn.userInteractionEnabled = NO;
        //将按钮添加到TabBar
        [self addSubview:addBtn];
        self.centerButton = addBtn;
    }
    return self;
}

//响应中间“+”按钮点击事件
-(void)addBtnDidClick{
    if([self.myTabBarDelegate respondsToSelector:@selector(centerButtonClick:)]){
        [self.myTabBarDelegate centerButtonClick:self];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //去掉TabBar上部的横线
    /*
    for (UIView *view in self.subviews){
        if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1)   //横线的高度为0.5
        {
            UIImageView *line = (UIImageView *)view;
            line.hidden = YES;
        }
    }
    */


    //设置“+”按钮的位置
    self.centerButton.centerX = self.centerX;
    self.centerButton.centerY = 0;
    //设置“+”按钮的大小为图片的大小
    CGFloat btnW = 52;
    self.centerButton.size = CGSizeMake(btnW, btnW);
    
    /*
    //创建并设置“+”按钮下方的文本为“添加”
    UILabel *addLbl = [[UILabel alloc] init];
    addLbl.text = @"质押挖矿";
    addLbl.font = [UIFont systemFontOfSize:10];
    addLbl.textColor = [UIColor grayColor];
    [addLbl sizeToFit];

    //设置“添加”label的位置
    addLbl.centerX = self.centerButton.centerX;
    addLbl.centerY = CGRectGetMaxY(self.centerButton.frame) + 10;

    [self addSubview:addLbl];

    self.centerLabel = addLbl;
    */

    int btnIndex = 0;
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) {//遍历TabBar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度等于TabBar的三分之一
            btn.width = self.width / 3;

            btn.x = btn.width * btnIndex;

            btnIndex++;
            //如果索引是1(即“+”按钮)，直接让索引加一
            if (btnIndex == 1) {
                btnIndex++;
            }

        }
    }
    //将“+”按钮放到视图层次最前面
    [self bringSubviewToFront:self.centerButton];
}

//重写hitTest方法，去监听"+"按钮和“添加”标签的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有TabBar的，那么肯定是在根控制器页面
    //在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或“添加”标签上
    //是的话让“+”按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    /*
    if (self.isHidden == NO){

        //将当前TabBar的触摸点转换坐标系，转换到“+”按钮的身上，生成一个新的点
        CGPoint newA = [self convertPoint:point toView:self.centerButton];
        //将当前TabBar的触摸点转换坐标系，转换到“添加”标签的身上，生成一个新的点
        CGPoint newL = [self convertPoint:point toView:self.centerLabel];

        //判断如果这个新的点是在“+”按钮身上，那么处理点击事件最合适的view就是“+”按钮
        if ( [self.centerButton pointInside:newA withEvent:event])
        {
            return self.centerButton;
        }
        //判断如果这个新的点是在“添加”标签身上，那么也让“+”按钮处理事件
        else if([self.centerLabel pointInside:newL withEvent:event])
        {
            return self.centerButton;
        }
        else
        {//如果点不在“+”按钮身上，直接让系统处理就可以了

            return [super hitTest:point withEvent:event];
        }
    }
    else
    {
        //TabBar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
    */
    return [super hitTest:point withEvent:event];

}

@end
