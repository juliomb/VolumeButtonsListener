## VolumeButtonsListener
With this little class, you would be able to listen and handle events produced by the volume buttons.

I am aware that this is a 'hackish' approach, but I tried to find better solutions and I couldn't. Please, if you discover a proper solution, let me know =)

------
### Instructions
Call the following function only once, for example in the `didFinishLaunchingWithOptions`, to not show the HUD when buttons are pressed.

```swift
VolumeButtonsListener.hideVolumeHUD()
```
Start listening, (f.e: `viewWillAppear`, `UIApplicationDidBecomeActive`):

```swift
VolumeButtonsListener.listen(){ 
	// Do your stuff here
}
```
And finally, when you are done (f.e: `viewWillDisappear`, `UIApplicationDidEnterBackground`).

```swift
VolumeButtonsListener.stopListen()
```
------

Please, feel free to suggest improvements!

Thanks Henk for your necessary help.