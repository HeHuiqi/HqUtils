//
//  HqChatMoreActionView.m
//  HqUtils
//
//  Created by hehuiqi on 2019/12/12.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqChatMoreActionView.h"

@implementation HqChatMoreActionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.items = @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""];
        HqListItemModel *picItem = [HqListItemModel item];
        picItem.hq_key = @"照片";
        picItem.tag = 0;
        picItem.hq_icon_name = @"lc_chat_pic_icon";
        
        HqListItemModel *redBagItem = [HqListItemModel item];
        redBagItem.hq_key = @"红包";
        redBagItem.hq_icon_name = @"lc_chat_redbag_icon";
        redBagItem.tag = 1;
        NSArray *setionItems = @[picItem,redBagItem];
        self.items = @[setionItems];

        [self setup];
    }
    return self;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        CGFloat itemW = SCREEN_WIDTH;
        CGFloat itemH = 300;
        layout.itemSize = CGSizeMake(itemW, itemH);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:HqMoreActionViewCell.class forCellWithReuseIdentifier:HqMoreActionViewCellId];
    }
    return _collectionView;
}
- (void)setup{
    [self addSubview:self.collectionView];
    [self hqLayoutSuviews];
}
- (void)hqLayoutSuviews{
    
}
#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HqMoreActionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HqMoreActionViewCellId forIndexPath:indexPath];
//    lc_chat_pic_icon
    NSArray *setionItems = self.items[indexPath.row];
    cell.items = setionItems;
    cell.delegate = self;
    return cell;
}
#pragma mark - HqMoreActionViewProtocol
- (void)morecActionClickItem:(HqListItemModel *)item{
    if ([self.delegate respondsToSelector:@selector(morecActionClickItem:)] && self.delegate) {
        [self.delegate morecActionClickItem:item];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    self.collectionView.frame = self.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
