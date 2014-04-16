//
//  GJMLessCrashySKView.m
//  Foundation
//
//  Created by George MacKerron on 15/04/2014.
//  Copyright (c) 2014 George MacKerron. MIT licenced.
//

#import "GJMLessCrashySKView.h"

#define NCenter NSNotificationCenter.defaultCenter
#define AppActive (UIApplication.sharedApplication.applicationState == UIApplicationStateActive)

@implementation GJMLessCrashySKView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [NCenter addObserver:self selector:@selector(appWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [NCenter addObserver:self selector:@selector(appDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
  }
  return self;
}

- (void)dealloc {
  [NCenter removeObserver:self];
}

- (void)layoutSubviews {
  _skView.frame = self.bounds;
  _snapshotView.frame = self.bounds;
}

- (void)configureForAppActive:(BOOL)appActive selfVisible:(BOOL)selfVisible {
  if (appActive && selfVisible) {
    if (_snapshotView) [self destroySnapshot];
    [self makeSKView];
  } else {
    if (selfVisible) [self makeSnapshot];
    [self destroySKView];
  }
}

- (void)appWillResignActive {
  [self configureForAppActive:NO selfVisible: !! self.window];
}

- (void)appDidBecomeActive {
  [self configureForAppActive:YES selfVisible: !! self.window];
}

- (void)willMoveToWindow:(UIWindow *)window {
  if (! window) [self configureForAppActive:AppActive selfVisible:NO];
}

- (void)didMoveToWindow {
  if (self.window) [self configureForAppActive:AppActive selfVisible:YES];
}

- (void)makeSnapshot {
  _snapshotView = [_skView snapshotViewAfterScreenUpdates:NO];
  _snapshotView.frame = _skView.frame;
  [self insertSubview:_snapshotView belowSubview:_skView];
}

- (void)destroySnapshot {
  [UIView animateWithDuration:0.5f
                   animations:^{
                     _snapshotView.alpha = 0.0f;
                   }
                   completion:^ (BOOL finished) {
                     [_snapshotView removeFromSuperview];
                     _snapshotView = nil;
                   }];
}

- (void)makeSKView {
  _skView = [[SKView alloc] initWithFrame:self.bounds];
  if (_skScene) [_skView presentScene:_skScene];
  [self addSubview:_skView];
  [self sendSubviewToBack:_skView];  // in case we're about to fade out a snapshot
}

- (void)destroySKView {
  [_skView removeFromSuperview];
  _skView = nil;
}


- (void)presentScene:(GJMLessCrashySKScene*)scene {
  _skScene = scene;
  [_skView presentScene:scene];
  [scene didMoveToGJMLessCrashySKView:self];
}

- (SKScene*)scene {
  return _skScene;
}


- (SKTexture *)textureFromNode:(SKNode *)node {
  return [_skView textureFromNode:node];
}
- (CGPoint)convertPoint:(CGPoint)point toScene:(SKScene *)scene {
  return [_skView convertPoint:point toScene:scene];
}
- (CGPoint)convertPoint:(CGPoint)point fromScene:(SKScene *)scene {
  return [_skView convertPoint:point fromScene:scene];
}

@end

@implementation GJMLessCrashySKScene

- (GJMLessCrashySKView*)view {
  return (GJMLessCrashySKView*)super.view.superview;
}

- (void)didMoveToGJMLessCrashySKView:(GJMLessCrashySKView*)view {
  // no-op
}

@end
