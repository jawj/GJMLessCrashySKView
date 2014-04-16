//
//  GJMLessCrashySKView.h
//  Foundation
//
//  Created by George MacKerron on 15/04/2014.
//  Copyright (c) 2014 George MacKerron. MIT licenced.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>


@class GJMLessCrashySKScene;

@interface GJMLessCrashySKView : UIView {
  SKView* _skView;
  UIView* _snapshotView;
  GJMLessCrashySKScene* _skScene;
}

@property (nonatomic, readonly) SKScene *scene;

- (void)presentScene:(SKScene *)scene;
- (SKTexture *)textureFromNode:(SKNode *)node;
- (CGPoint)convertPoint:(CGPoint)point toScene:(SKScene *)scene;
- (CGPoint)convertPoint:(CGPoint)point fromScene:(SKScene *)scene;

@end

@interface GJMLessCrashySKScene : SKScene

- (void)didMoveToGJMLessCrashySKView:(GJMLessCrashySKView*)view;

@end
