//
//  PlayerTabBar.m
//  EffortlessEnglish
//
//  Created by wangyuehong on 16/8/13.
//  Copyright © 2016年 Oradt. All rights reserved.
//

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
        self.musicURL = [[NSBundle mainBundle] URLForResource:@"Day of the Dead Audio" withExtension:@"mp3"];
        self.playerItem = [AVPlayerItem playerItemWithURL:self.musicURL];
        self.player = [AVPlayer playerWithPlayerItem:self.playerItem];

        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        layer.videoGravity = AVLayerVideoGravityResizeAspect;
        layer.frame = CGRectMake(0, 0, 1, 1);
        layer.backgroundColor = [[UIColor clearColor] CGColor];
        [self.layer addSublayer:layer];

        [self addPlayButton];
        [self addNextButton];
        [self addPrevButton];
    }
    return self;
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
    [button addTarget:self action:@selector(playBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
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
}

- (void)addPrevButton {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:kImage(@"MusicPlayer_上一个") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(playBtnClickHandler) forControlEvents:UIControlEventTouchUpInside];
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
}

@end
