//
//  PlayView.m
//  iOSVideoPlay
//
//  Created by macpro on 15/8/31.
//  Copyright © 2015年 macpro. All rights reserved.
//

//为了隐藏状态栏请在info.plist文件添加如下键值
// 键：View controller-based status bar appearance 值：NO

#define BUTTON_HEIFHT 44
#define BUTTON_WIDTH 50
#import <MediaPlayer/MediaPlayer.h>
#import "PlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PlayView ()<NSURLConnectionDataDelegate, AVAssetResourceLoaderDelegate>

@property (nonatomic,strong) UISlider *volumeSlider;
@property (nonatomic,assign) BOOL isFullScreen;

@end

@implementation PlayView
- (void)dealloc
{
    [self removeNotification];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [self removeObserverFromPlayer:self.player];
    self.player = nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initPlayerLayer];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withVideoURLString:(NSString *)urlstring
{
    if (self = [super initWithFrame:frame])
    {
        [self setAudio];
        [self setAudioVolume];
        self.videoURLString = urlstring;
        [self initPlayerLayer];
        self.originalFrame =frame;
        
    }
    return self;
}
- (void)initPlayerLayer
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapChange:)]];
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView:)]];
    
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.layer addSublayer:self.playerLayer];
    
    self.controlView = [[UIView alloc]init];
    self.controlView .backgroundColor = [UIColor blackColor];
    self.controlView .alpha = 0.5;
    [self addSubview: self.controlView ];
    
    self.controlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.controlBtn setImage:[UIImage imageNamed:@"big_icon.png"] forState:UIControlStateNormal];
    
    [self.controlBtn setImage:[UIImage imageNamed:@"small_icon.png"] forState:UIControlStateSelected];
    [self.controlBtn addTarget:self action:@selector(changeFrame:) forControlEvents:UIControlEventTouchUpInside];
    [self.controlView addSubview:self.controlBtn];
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"san_jiao.png"] forState:UIControlStateSelected];
    [self.playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"selete = =%d",self.playBtn.selected);
    [self.controlView addSubview:self.playBtn];

    
    self.progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.controlView addSubview:self.progressView];
    
    
}
- (void)panView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan locationInView:pan.view];
    CGFloat y = point.y;
    CGFloat x = point.x;
    float value = 1.0 - y/self.bounds.size.height;
    
//    NSLog(@"ppp==%@",NSStringFromCGPoint(point));
    NSLog(@"kkkk==%f",value);

    if (x >= self.bounds.size.width/2)
    {
        if (y <=100)
        {
            [_volumeSlider setValue:1.0 animated:YES];
            
        }
        else if(y  >= 200)
        {
            [_volumeSlider setValue:0.0 animated:YES];
        }
        else
        {
            [_volumeSlider setValue:value animated:YES];
        }
    }
    else
    {
        if (y <=100)
        {
            //5.0以上
            [[UIScreen mainScreen] setBrightness:1.0];
        }
        else if(y  >= 200)
        {
            [[UIScreen mainScreen] setBrightness:0.0];
        }
        else
        {
            [[UIScreen mainScreen] setBrightness:value];
        }

    }
}

#pragma mark 设置音量
- (void)setAudioVolume
{
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeSlider = (UISlider*)view;
            break;
        }
    }
    [_volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)setAudio
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //静音状态下播放
    [audioSession setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setActive:YES
                                         error:nil];
    //处理电话打进时中断音乐播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterruption:) name:AVAudioSessionInterruptionNotification object:audioSession];
    //后台播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback
                                           error:nil];
}
- (void)handleInterruption:(NSNotification *)notifi
{
    //处理打断
    NSLog(@"处理打断");
}
- (AVPlayer *)player
{
    if (_player == nil)
    {
        _playerItem = [self getPlayItem];
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        [self addProgressObserver];
        [self addNotification];
        [self addObserverToPlayerItem:_playerItem];
        [self addObserverToPlayerRate:_player];
    }
    return _player;
}

- (NSURL *)songURL
{
    //http://7u2klj.com2.z0.glb.clouddn.com/QY1xq6_4diU6-Er-2he1LaodBb0=/FsmC5SL2g6CQ-hslYBorLLSB68sb
    return [NSURL URLWithString:@"http://7u2klj.com2.z0.glb.clouddn.com/QY1xq6_4diU6-Er-2he1LaodBb0=/FsmC5SL2g6CQ-hslYBorLLSB68sb"];
}

- (NSURL *)songURLWithCustomScheme:(NSString *)scheme
{
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:[self songURL] resolvingAgainstBaseURL:NO];
    components.scheme = scheme;
    
    return [components URL];
}

- (AVPlayerItem *)getPlayItem
{
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[self songURLWithCustomScheme:@"streaming"] options:nil];
    [asset.resourceLoader setDelegate:self queue:dispatch_get_main_queue()];
    self.pendingRequests = [NSMutableArray array];

    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];

//    NSURL *url=[NSURL URLWithString:self.videoURLString];
//    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
    return playerItem;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.controlView.frame = CGRectMake(0, self.bounds.size.height-BUTTON_HEIFHT, self.bounds.size.width, BUTTON_HEIFHT);
    self.controlBtn.frame = CGRectMake(self.bounds.size.width - BUTTON_WIDTH,0 , 50, BUTTON_HEIFHT);
    self.playBtn.frame = CGRectMake(0,0 , BUTTON_WIDTH, BUTTON_HEIFHT);

    //进度条
    self.progressView.frame = CGRectMake(CGRectGetMaxX(self.playBtn.frame),20 , self.bounds.size.width-BUTTON_WIDTH*2, BUTTON_HEIFHT);
    //滑块
//    self.slider.frame = CGRectMake(CGRectGetMaxX(self.playBtn.frame),0 , self.bounds.size.width-BUTTON_WIDTH*2, BUTTON_HEIFHT);
    
    self.playerLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

    
    self.playerLayer.videoGravity = AVLayerVideoGravityResize;
    
}
#pragma mark - 控制全屏
- (void)changeFrame:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected)
    {
        if ([self.delegate respondsToSelector:@selector(playView:isFullScreen:)])
        {
            [self.delegate playView:self isFullScreen:YES];
            [self pLayWithIsFullScreen:YES];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(playView:isFullScreen:)])
        {
            [self.delegate playView:self isFullScreen:NO];
           
            [self pLayWithIsFullScreen:NO];
        }
    }
}
#pragma mark - 监听播放进度
-(void)addProgressObserver{
    AVPlayerItem *playerItem=self.player.currentItem;    
    __weak PlayView *weakSelf = self;
    //这里设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current=CMTimeGetSeconds(time);
        float total=CMTimeGetSeconds([playerItem duration]);
        
        if (current) {
            [weakSelf.progressView setProgress:(current/total) animated:YES];
        }
    }];
}
#pragma mark - 控制显示播放进度
- (void)tapChange:(UITapGestureRecognizer *)tap
{
    _isHiden = !_isHiden;
    if (_isHiden)
    {
        self.controlView.hidden = YES;
    }
    else
    {
        
        self.controlView.hidden = NO;
        
    }
    
}
#pragma mark - 播放
- (void)playBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;

    if (_isStop)
    {
        if ([self.delegate respondsToSelector:@selector(playView:isAgainPlay:)])
        {
            [self.delegate playView:self isAgainPlay:YES];
        }
        [self.player play];
        _isStop = NO;
    }
    else
    {
        if (btn.selected)
        {
            [self.player pause];
        }
        else
        {
            [self.player play];
        }
    }

   
}
#pragma mark - 添加通知

-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 播放完成
-(void)playbackFinished:(NSNotification *)notification{
    
    if ([self.delegate respondsToSelector:@selector(playView:playComplate:)])
    {
        [self.delegate playView:self playComplate:YES];
        
        if (self.controlBtn.selected == YES)
        {
            [self pLayWithIsFullScreen:NO];
        }
        [self.player.currentItem seekToTime:kCMTimeZero];
        self.controlBtn.selected = NO;
        self.playBtn.selected = YES;
        self.controlView.hidden = NO;
        self.progressView.progress = 0.0;
        self.slider.value = 0.0;
        self.isStop = YES;

    }
}
#pragma mark - KVO

-(void)addObserverToPlayerRate:(AVPlayer *)plyer
{
    [plyer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
-(void)removeObserverFromPlayer:(AVPlayer *)player
{
    [player removeObserver:self forKeyPath:@"rate"];
}

/*
//通过KVO监控播放器状态
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            //NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            NSLog(@"正在播放.正在播放.正在播放. ");
            [self.player play];

        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        totalBuffer = totalBuffer;
        NSLog(@"缓冲：%.2f",durationSeconds);

        if (durationSeconds > 5.0)
        {
          
        }
    }
    else if([keyPath isEqualToString:@"rate"])
    {

        if (self.player.rate == 0.0) {
            
            self.playBtn.selected = YES;
        }
        else
        {
            self.playBtn.selected = NO;
        }
        NSLog(@"rate = %f",_player.rate);

    }
}*/
#pragma mark - 是否全屏播放
- (void)pLayWithIsFullScreen:(BOOL)isFull
{
    if (self.isFullScreen) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = self.originalFrame;
        }];
        
        return;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:isFull withAnimation:UIStatusBarAnimationFade];
   
   
    CGSize size  = [UIScreen mainScreen].bounds.size;
    [UIView animateWithDuration:0.3 animations:^{
        
        
        
        if (isFull)
        {
             [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
            
            CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
            self.transform = transform;
           
            self.frame = CGRectMake(0, 0, size.width, size.height);
        }
        else
        {
             [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
            CGAffineTransform transform = CGAffineTransformMakeRotation(0);
            self.transform = transform;
            self.frame = self.originalFrame;
        }
        
    }];
}
- (void)pLayWithInterfaceOrientation:(UIInterfaceOrientation)orientation withHidenStatusBar:(BOOL)hiden
{
    [[UIApplication sharedApplication] setStatusBarHidden:hiden withAnimation:UIStatusBarAnimationFade];
    CGSize size  = [UIScreen mainScreen].bounds.size;
    self.interfaceOrientation = orientation;
    if (orientation == UIInterfaceOrientationPortrait)
    {
        self.frame = self.originalFrame;
        self.controlBtn.selected = NO;
        self.isFullScreen = NO;
    }
    
    if (orientation == UIInterfaceOrientationLandscapeRight)
    {
        self.isFullScreen = YES;
        self.frame = CGRectMake(0, 0, size.width, size.height);
        self.controlBtn.selected = YES;
    }
}


#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.songData = [NSMutableData data];
    self.response = (NSHTTPURLResponse *)response;
    
    [self processPendingRequests];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.songData appendData:data];
    
    [self processPendingRequests];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self processPendingRequests];
    
    NSString *cachedFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cached.mp4"];
    NSLog(@"cachedFilePath == %@",cachedFilePath);
    [self.songData writeToFile:cachedFilePath atomically:YES];
}

#pragma mark - AVURLAsset resource loading

- (void)processPendingRequests
{
    NSMutableArray *requestsCompleted = [NSMutableArray array];
    
    NSLog(@"================ %@",self.pendingRequests);

    for (AVAssetResourceLoadingRequest *loadingRequest in self.pendingRequests)
    {
        NSLog(@"================");
        
        [self fillInContentInformation:loadingRequest.contentInformationRequest];
        
        BOOL didRespondCompletely = [self respondWithDataForRequest:loadingRequest.dataRequest];
        
        if (didRespondCompletely)
        {
            [requestsCompleted addObject:loadingRequest];
            
            [loadingRequest finishLoading];
        }
    }
    
    [self.pendingRequests removeObjectsInArray:requestsCompleted];
}

- (void)fillInContentInformation:(AVAssetResourceLoadingContentInformationRequest *)contentInformationRequest
{
    if (contentInformationRequest == nil || self.response == nil)
    {
        return;
    }
    
    NSString *mimeType = [self.response MIMEType];
    CFStringRef contentType = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)(mimeType), NULL);
    
    contentInformationRequest.byteRangeAccessSupported = YES;
    contentInformationRequest.contentType = CFBridgingRelease(contentType);
    contentInformationRequest.contentLength = [self.response expectedContentLength];
}

- (BOOL)respondWithDataForRequest:(AVAssetResourceLoadingDataRequest *)dataRequest
{
    
    long long startOffset = dataRequest.requestedOffset;
    if (dataRequest.currentOffset != 0)
    {
        startOffset = dataRequest.currentOffset;
    }
    
    // Don't have any data at all for this request
    if (self.songData.length < startOffset)
    {
        return NO;
    }
    
    // This is the total data we have from startOffset to whatever has been downloaded so far
    NSUInteger unreadBytes = self.songData.length - (NSUInteger)startOffset;
    
    // Respond with whatever is available if we can't satisfy the request fully yet
    NSUInteger numberOfBytesToRespondWith = MIN((NSUInteger)dataRequest.requestedLength, unreadBytes);
    
    [dataRequest respondWithData:[self.songData subdataWithRange:NSMakeRange((NSUInteger)startOffset, numberOfBytesToRespondWith)]];
    
    long long endOffset = startOffset + dataRequest.requestedLength;
    BOOL didRespondFully = self.songData.length >= endOffset;
    
    return didRespondFully;
}


- (BOOL)resourceLoader:(AVAssetResourceLoader *)resourceLoader shouldWaitForLoadingOfRequestedResource:(AVAssetResourceLoadingRequest *)loadingRequest
{
    if (self.connection == nil)
    {
        NSURL *interceptedURL = [loadingRequest.request URL];
        NSURLComponents *actualURLComponents = [[NSURLComponents alloc] initWithURL:interceptedURL resolvingAgainstBaseURL:NO];
        actualURLComponents.scheme = @"http";
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[actualURLComponents URL]];
        self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [self.connection setDelegateQueue:[NSOperationQueue mainQueue]];
        
        [self.connection start];
    }
//    NSLog(@"loadingRequest == %@",loadingRequest);
    [self.pendingRequests addObject:loadingRequest];
    
    return YES;
}

- (void)resourceLoader:(AVAssetResourceLoader *)resourceLoader didCancelLoadingRequest:(AVAssetResourceLoadingRequest *)loadingRequest
{
    [self.pendingRequests removeObject:loadingRequest];
}

@end
