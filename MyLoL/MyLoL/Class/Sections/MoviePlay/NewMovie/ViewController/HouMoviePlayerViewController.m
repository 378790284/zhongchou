//
//  HouMoviePlayerViewController.m
//  自定义播放器demo
//
//  Created by 侯志超 on 15/7/13.
//  Copyright (c) 2015年 侯志超. All rights reserved.
//

#import "HouMoviePlayerViewController.h"
#import "HouMoviePlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface HouMoviePlayerViewController ()
//  视频的显示页面（亲们，你可以根据需求自定义）
@property (nonatomic, strong) HouMoviePlayerView *houMoviewPlayerView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, assign) BOOL isFirstTap;
@property (nonatomic, assign) BOOL isPlayOrParse;

//  保存该视频资源的总时长，快进或快退的时候要用
@property (nonatomic, assign) CGFloat totalMovieDuration;
@end

@implementation HouMoviePlayerViewController

//  使用MVC可以使用重写loadView方法，也可以使用在viewDidLoad方法中直接加载View，都可以使用，方法自己取舍
- (void)loadView
{
    //  创建需要显示的视图
    self.houMoviewPlayerView = [[HouMoviePlayerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _houMoviewPlayerView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  注册观察者用来观察，是否播放完毕
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
   //   创建视频播放器层
    //  大家应该看到了appDelgate.m中的注释了，AVPlayer要显示必须创建一个播放器层AVPlayerLayer用于展示，播放器层继承于CALayer，有了AVPlayerLayer之添加到控制器视图的layer中即可
    
    //  创建显示层
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //  设置frame
    CGRect frame = self.view.bounds;
    frame.size.height = self.view.bounds.size.width;
    frame.size.width = self.view.bounds.size.height;
    playerLayer.frame = frame;
    //  这是视屏的填充模式,默认为AVLayerVideoGravityResizeAspect
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //  插入到view的层上面，我没有用addSublayer，因为我想让播放的视图在最下层
    [self.view.layer insertSublayer:playerLayer atIndex:0];
    
    self.houMoviewPlayerView.movieName.text = self.titleName;
    //  返回按钮的点击事件
    [self.houMoviewPlayerView.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //  播放按钮的点击事件
    [self.houMoviewPlayerView.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  播放页面添加轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllSubviews:)];
    [self.view addGestureRecognizer:tap];

    //  给音量的滑杆设置事件
    [self.houMoviewPlayerView.voiceSlider addTarget:self action:@selector(voiceSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    //  给进度的滑杆设置事件
    [self.houMoviewPlayerView.progressSlider addTarget:self action:@selector(scrubberIsScrolling:) forControlEvents:UIControlEventValueChanged];
    
    //  分享按钮的点击事件
    [self.houMoviewPlayerView.shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  收藏按钮的点击事件
    [self.houMoviewPlayerView.colletionButton addTarget:self action:@selector(colletionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //  缓存按钮的点击事件
    [self.houMoviewPlayerView.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 返回按钮的点击事件
- (void)backButtonAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

    NSLog(@"您点击了返回");
}

#pragma mark 分享按钮的点击事件
- (void)shareButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了分享！");
}
#pragma mark 收藏按钮的点击事件
- (void)colletionButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了收藏！");
}
#pragma mark 缓存按钮的点击事件
- (void)saveButtonAction:(UIButton *)sender
{
    NSLog(@"您点击了保存！");
}



#pragma mark 轻拍手势的事件
//  用于把上面的操作视图动画隐藏
- (void)dismissAllSubviews:(UITapGestureRecognizer *)tap
{
    //  防止循环引用，讲过的！
    __weak typeof(self) myself = self;
    if (!self.isFirstTap) {
        
        [UIView animateWithDuration:.2f animations:^{
            
            myself.houMoviewPlayerView.topOperationView.frame = CGRectMake(0, -54, self.view.frame.size.width, 54);
            myself.houMoviewPlayerView.bottomOperationView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 65);
            myself.houMoviewPlayerView.leftOperationView.frame = CGRectMake(-45, 62, 45, 185);
            myself.houMoviewPlayerView.rightOperationView.frame = CGRectMake(self.view.frame.size.width, 62, 45, 185);
            myself.isFirstTap = YES;
            
        }];
    } else{
        [UIView animateWithDuration:.2f animations:^{
            
            myself.houMoviewPlayerView.topOperationView.frame = CGRectMake(0, 0, self.view.frame.size.width, 54);
            myself.houMoviewPlayerView.bottomOperationView.frame = CGRectMake(0, self.view.frame.size.height - 65, self.view.frame.size.width, 65);
            myself.houMoviewPlayerView.leftOperationView.frame = CGRectMake(0, 62, 45, 185);
            myself.houMoviewPlayerView.rightOperationView.frame = CGRectMake(self.view.frame.size.width - 45, 62, 45, 185);
            myself.isFirstTap = NO;
        }];
        
}
}

#pragma mark 播放或暂停
- (void)playButtonAction:(UIButton *)sender
{
    
    //  在这里你可以自己设置bool值来判断是否正在播放或者已经停止，也可以通过，播放器自带的rate属性，当rate为0时，为暂停，当rate为1时为正在播放
    
    if (!self.isPlayOrParse) {
        [self.player play];
        [sender setBackgroundImage:[UIImage imageNamed:@"播放器_暂停"] forState:UIControlStateNormal];
        self.isPlayOrParse = YES;
    } else{
        //  视屏播放器暂停
        [self.player pause];
        
        //  切换图片
        [sender setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
        self.isPlayOrParse = NO;
        
    }
}

#pragma mark 调节音量
- (void)voiceSliderValueChange:(UISlider *)sender
{
    [self.player setVolume:sender.value];
    if (sender.value == 0) {
        self.houMoviewPlayerView.voiceImageView.image = [UIImage imageNamed:@"播放器_静音"];
    }else{
        self.houMoviewPlayerView.voiceImageView.image = [UIImage imageNamed:@"播放器_音量"];
    }

}

#pragma mark 调节进度
- (void)scrubberIsScrolling:(UISlider *)sender
{
    //  先暂停
    [self.player pause];
    //  图片切换
    [self.houMoviewPlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
    
    float current = (float)(self.totalMovieDuration * sender.value);
    CMTime currentTime = CMTimeMake(current, 1);
    //  给avplayer设置进度
    [self.player seekToTime:currentTime completionHandler:^(BOOL finished) {
        [self.houMoviewPlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_暂停"] forState:UIControlStateNormal];
        [self.player play];
    }];

}

#pragma mark 播放结束后的代理回调
- (void)moviePlayDidEnd:(NSNotification *)notify
{
    //  播放按钮设置成播放图片
    [self.houMoviewPlayerView.playButton setBackgroundImage:[UIImage imageNamed:@"播放器_播放"] forState:UIControlStateNormal];
}

//avplayer的懒加载
- (AVPlayer *)player
{
    if (!_player) {
        if (self.movieURL) {
            AVPlayerItem *item = [AVPlayerItem playerItemWithURL:self.movieURL];
            
            // NSLog(@"%@", item.duration);
            self.player = [AVPlayer playerWithPlayerItem:item];
            //  添加进度观察
            [self addProgressObserver];
            
            [self addObserverToPlayerItem:item];
            
        }
    }
    return _player;
}

//  依靠AVPlayer的- (id)addPeriodicTimeObserverForInterval:(CMTime)interval queue:(dispatch_queue_t)queue usingBlock:(void (^)(CMTime time))block方法获得播放进度，这个方法会在设定的时间间隔内定时更新播放进度，通过time参数通知客户端。相信有了这些视频信息播放进度就不成问题了，事实上通过这些信息就算是平时看到的其他播放器的缓冲进度显示以及拖动播放的功能也可以顺利的实现。
- (void)addProgressObserver{
    //  获取当前媒体资源管理对象
    AVPlayerItem *playerItem = self.player.currentItem;
    
    __weak typeof(self) mySelf = self;
    //  设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //  获取当前的进度
        float current = CMTimeGetSeconds(time);
        //  获取全部资源的大小
        float total = CMTimeGetSeconds([playerItem duration]);
        //  计算出进度
        if (current) {
            [mySelf.houMoviewPlayerView.progressSlider setValue:(current / total) animated:YES];
            
            NSDate *d = [NSDate dateWithTimeIntervalSince1970:current];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            if (current/3600 >=1) {
                [formatter setDateFormat:@"HH:mm:ss"];
            }else{
                [formatter setDateFormat:@"00:mm:ss"];
            }
            NSString * showTimeNew = [formatter stringFromDate:d];

            mySelf.houMoviewPlayerView.startTimeLabel.adjustsFontSizeToFitWidth = YES;
            
            mySelf.houMoviewPlayerView.startTimeLabel.text = showTimeNew;
            
            
            
        }
    }];	
    
}

//  这个方法，用来取得播放进度，播放进度就没有其他播放器那么简单了。在系统播放器中通常是使用通知来获得播放器的状态，媒体加载状态等，但是无论是AVPlayer还是AVPlayerItem（AVPlayer有一个属性currentItem是AVPlayerItem类型，表示当前播放的视频对象）都无法获得这些信息。当然AVPlayerItem是有通知的，但是对于获得播放状态和加载状态有用的通知只有一个：播放完成通知AVPlayerItemDidPlayToEndTimeNotification。在播放视频时，特别是播放网络视频往往需要知道视频加载情况、缓冲情况、播放情况，这些信息可以通过KVO监控AVPlayerItem的status、loadedTimeRanges属性来获得当AVPlayerItem的status属性为AVPlayerStatusReadyToPlay是说明正在播放，只有处于这个状态时才能获得视频时长等信息；当loadedTimeRanges的改变时（每缓冲一部分数据就会更新此属性）可以获得本次缓冲加载的视频范围（包含起始时间、本次加载时长），这样一来就可以实时获得缓冲情况。

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


//  观察者的方法，会在加载好后触发，我们可以在这个方法中，保存总文件的大小，用于后面的进度的实现
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            
            CMTime totalTime = playerItem.duration;
            //因为slider的值是小数，要转成float，当前时间和总时间相除才能得到小数,因为5/10=0
            self.totalMovieDuration = (CGFloat)totalTime.value/totalTime.timescale;
            
            NSDate *d = [NSDate dateWithTimeIntervalSince1970:_totalMovieDuration];

            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            if (_totalMovieDuration/3600 >=1) {
                [formatter setDateFormat:@"HH:mm:ss"];
            }else{
                [formatter setDateFormat:@"00:mm:ss"];
            }
            NSString * showTimeNew = [formatter stringFromDate:d];
            self.houMoviewPlayerView.endTimeLabel.adjustsFontSizeToFitWidth = YES;
            self.houMoviewPlayerView.endTimeLabel.text = showTimeNew;
            
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
        //
    }
}

//  进入该视图控制器自动横屏进行播放
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    //  移除观察者,使用观察者模式的时候，记得在不使用的时候，进行移除
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
