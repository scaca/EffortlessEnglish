//
//  PlayerTabBar.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/13.
//  Copyright © 2016年 Oradt. All rights reserved.
//

#import "MusicQueue.h"
#import "PlayerTabBar.h"

#define BUTTON_SPACE 20
#define BUTTON_WIDTH 36

@interface PlayerTabBar ()

@property(nonatomic, strong) UIButton *playButton;  // 播放按钮
@property(nonatomic, strong) UILabel *titleLabel;   // 歌名Label
@property(nonatomic, strong) UIButton *prevButton;  // 上一曲
@property(nonatomic, strong) UIButton *nextButton;  // 下一曲

@property(nonatomic, strong) NSURL *musicURL;
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation PlayerTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];

        self.musicURL =
            [[NSBundle mainBundle] URLForResource:[[MusicQueue defaultInstance] currentMusic] withExtension:@"mp3"];
        self.playerItem = [AVPlayerItem playerItemWithURL:self.musicURL];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];

        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.frame = CGRectMake(0, 0, 1, 1);
        layer.backgroundColor = [[UIColor clearColor] CGColor];
        [self.layer addSublayer:layer];

        [self addPlayButton];
        [self addTitleLabel];
        [self addNextButton];
        [self addPrevButton];

        [self addEndTimeNotification];
    }
    return self;
}

- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Day of the Dead Audio";
    label.numberOfLines = 2;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    self.titleLabel = label;
    @weakify(self);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      @strongify(self);
      make.left.equalTo(self.playButton.mas_right).offset(BUTTON_SPACE);
      make.width.mas_equalTo(kScreen_Width - BUTTON_WIDTH * 3 - BUTTON_SPACE * 5);
      make.height.equalTo(self.playButton);
      make.centerY.equalTo(self);
    }];
}
- (void)addPlayButton {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:kImage(@"MusicPlayer_暂停") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.playButton = button;

    @weakify(self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      @strongify(self);
      make.left.equalTo(self).offset(BUTTON_SPACE);
      make.width.height.mas_equalTo(BUTTON_WIDTH);
      make.centerY.equalTo(self);
    }];
}

- (void)playBtnClickHandler {
    [self.player play];
}

- (void)addNextButton {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:kImage(@"MusicPlayer_下一个") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.nextButton = button;

    @weakify(self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      @strongify(self);
      make.right.equalTo(self).offset(-BUTTON_SPACE);
      make.width.height.mas_equalTo(BUTTON_WIDTH);
      make.centerY.equalTo(self);
    }];
}

- (void)nextBtnClickHandler {
    self.musicURL =
        [[NSBundle mainBundle] URLForResource:[[MusicQueue defaultInstance] nextMusic] withExtension:@"mp3"];
    self.playerItem = [AVPlayerItem playerItemWithURL:self.musicURL];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    [self.player play];
}

- (void)addPrevButton {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:kImage(@"MusicPlayer_上一个") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(prevBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.prevButton = button;

    @weakify(self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      @strongify(self);
      make.right.equalTo(self.nextButton.mas_left).offset(-BUTTON_SPACE);
      make.width.height.mas_equalTo(BUTTON_WIDTH);
      make.centerY.equalTo(self);
    }];
}

- (void)prevBtnClickHandler {
    self.musicURL =
        [[NSBundle mainBundle] URLForResource:[[MusicQueue defaultInstance] prevMusic] withExtension:@"mp3"];
    self.playerItem = [AVPlayerItem playerItemWithURL:self.musicURL];
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
}

- (void)addEndTimeNotification {
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
}

- (void)playbackFinished:(NSNotification *)notification {
    NSLog(@"播放完成.%@",[NSThread currentThread]);
    [self nextBtnClickHandler];
}

@end
