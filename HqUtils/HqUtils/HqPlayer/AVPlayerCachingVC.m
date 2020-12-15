//
//  AVPlayerCaching.m
//  DaysDemo
//
//  Created by macpro on 15/12/7.
//  Copyright © 2015年 macpro. All rights reserved.
//

//
//  ViewController.m
//  AVPlayerCaching
//
//  Created by Anurag Mishra on 5/19/14.
//  Sample code to demonstrate how to cache a remote audio file while streaming it with AVPlayer
//

#import "AVPlayerCachingVC.h"

#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <MediaPlayer/MediaPlayer.h>

@interface AVPlayerCachingVC () 

@property (nonatomic, strong) NSMutableData *songData;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic,strong) PlayView *playerView;
@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSMutableArray *pendingRequests;
@property(nonatomic,strong)MPMoviePlayerController *playerController;

@end

@implementation AVPlayerCachingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *video = @"https://v.qq.com/txp/iframe/player.html?vid=x0033t989f6";
//    video = @"http://7u2klj.com2.z0.glb.clouddn.com/QY1xq6_4diU6-Er-2he1LaodBb0=/FsmC5SL2g6CQ-hslYBorLLSB68sb";
//    video = @"https://f.video.weibocdn.com/002OAq5pgx07CuhKXojJ0104120040aN0E010.mp4?label=mp4_hd&template=576x1024.24.0&trans_finger=7c347e6ee1691b93dc7e5726f4ef34b3&Expires=1586924278&ssig=eYOrXkRUi7&KID=unistore,video";
//    _playerView = [[PlayView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 200) withVideoURLString:video];
//    [self.view addSubview:_playerView];
    
    NSURL *webVideoUrl = [NSURL URLWithString:video];
    self.playerController =[[MPMoviePlayerController alloc]initWithContentURL:webVideoUrl];
    self.playerController.view.frame = CGRectMake(0, 100, SCREEN_WIDTH, 300);
    [self.view addSubview: self.playerController.view];
    self.playerController.controlStyle = MPMovieControlStyleDefault;
    //设置是否自动播放(默认为YES）
//    self.playerController.shouldAutoplay = NO;
    [self.playerController play];
}

@end
