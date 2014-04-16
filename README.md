GJMLessCrashySKView
===================

An SKView stand-in that doesn't crash your app when audio is playing or freeze up when temporarily disappeared, addressing this annoying bug in iOS 7.0 and 7.1: http://stackoverflow.com/questions/18976813/sprite-kit-playing-sound-leads-to-app-termination

### What it does

GJMLessCrashySKView is a simple UIView subclass that offers the basic functions of an SKView and forwards them on to its own SKView subview. Crucially, though, it tears down this SKView whenever it goes off screen or the app resigns active, and rebuilds it if and when it comes back on screen and the app is active. 

If on-screen, it replaces the torn down SKView with a still snapshot of itself, and fades that out again when the SKView is rebuilt, so that when the app is inactive but still visible (e.g. a battery warning UIAlert is shown, or we've double-clicked the home button for the app switcher) everything looks normal.

### How to use it

Use GJMLessCrashySKView in place of all your SKViews, and GJMLessCrashySKScene in place of all your SKScenes. And, in your SKScenes, replace any implementations of `didMoveToView:` with `didMoveToGJMLessCrashySKView:`.

You may find that GJMLessCrashySKView doesn't implement various SKView properties that you need. Pull requests will be accepted happily for those.

You might also find that the methods it does forward on (e.g. the `convertPoint...` methods) don't work properly when the SKView is currently torn down. However, since you're most likely to be using those methods when the SKView is on-screen this may or may not be a problem.
