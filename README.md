# Zcode
### The missing Xcode launcher
<img src="https://raw.githubusercontent.com/zenangst/Xcode-Launcher/master/Images/icon_v3@2x.png" align="right">
Zcode is a simple OS X application that helps you launch, activate and even open files from the Finder in Xcode 6.4 in El Capitan Developer Preview 2.

### How it works

It's simple, it just checks if the Xcode process is running, if so; then it activates Xcode. However, if Xcode isn't running, then it launches Xcode via the terminal workaround. And if you chose to open files using Zcode, it will open it in Xcode 6.4.

### Install

Just download the latest release and drag and drop it into your applications folder, just like you would any other app. Then choose to always open Xcode related files with Zcode instead of Xcode.

Or if you are feeling adventures, you could download the source code and tinker with it if you like.

If you are looking for the old Apple Scripts, you can find them in the Scripts folder.

### Source

```swift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        activateOrOpenXcode()
    }

    func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        activateOrOpenXcode()

        return true
    }

    func application(sender: NSApplication, openFiles filenames: [AnyObject]) {
        let task = NSTask()
        task.launchPath = "/usr/bin/osascript"
        for file in filenames as! [String] {
            let appleScript = "tell application \"Xcode\"\n open \"\(file)\"\n\nend"
            task.arguments = ["-e", appleScript]
            task.launch()
        }
        activateXcode()
    }
    
    func activateOrOpenXcode() {
        let applications = NSWorkspace.sharedWorkspace().runningApplications as! [NSRunningApplication]
        let application = applications.filter { $0.localizedName == "Xcode" }.last

        if application != nil {
            self.activateXcode()
        } else {
            self.launchXcode()
        }
    }

    func activateXcode() {
        let task = NSTask()
        task.launchPath = "/usr/bin/osascript"
        task.arguments = ["-e", "tell application \"Xcode\" to activate"]
        task.launch()
    }

    func launchXcode() {
        let task = NSTask()
        task.launchPath = "/Applications/Xcode.app/Contents/MacOS/Xcode"
        task.arguments = ["</dev/null &>/dev/null &"]
        task.launch()
    }
}
```

### Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create pull request

### Who made this?

- Christoffer Winterkvist ([@zenangst](https://twitter.com/zenangst))

### Thanks

A big shout-out to [Sash Zats](https://twitter.com/zats), who made the initial [Xcode-Launcher](https://twitter.com/zats/status/613464620997570560) on which this is based.
