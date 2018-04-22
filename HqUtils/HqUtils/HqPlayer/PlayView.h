//
//  PlayView.h
//  iOSVideoPlay
//
//  Created by macpro on 15/8/31.
//  Copyright © 2015年 macpro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol PlayViewDelegate;
@interface PlayView : UIView

@property (nonatomic,assign) id<PlayViewDelegate> delegate;

@property (nonatomic,assign) CGRect originalFrame;//初始位置
@property (nonatomic,strong) NSString *videoURLString;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

@property (nonatomic,strong) UIView *controlView;//底部控制视图
@property (nonatomic,strong) UIProgressView *progressView;
@property (nonatomic,strong) UISlider *slider;

@property (nonatomic,strong) UIButton *controlBtn;
@property (nonatomic,strong) UIButton *playBtn;

@property (nonatomic,assign) BOOL isHiden;
@property (nonatomic,assign) BOOL isStop;
@property (nonatomic,assign) UIInterfaceOrientation interfaceOrientation;


@property (nonatomic, strong) NSMutableData *songData;
@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSMutableArray *pendingRequests;


- (instancetype)initWithFrame:(CGRect)frame withVideoURLString:(NSString *)urlstring;

@end

@protocol PlayViewDelegate <NSObject>

@optional
//全屏控制
- (void)playView:(PlayView *)playView isFullScreen:(BOOL)isFull;
//播放控制完成后再次播放
- (void)playView:(PlayView *)playView isAgainPlay:(BOOL)isPlay;
//播放完成
- (void)playView:(PlayView *)playView playComplate:(BOOL)isComplate;


@end