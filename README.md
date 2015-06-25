# Xcode-Launcher

Xcode-Launcher is a simple Apple script that helps you launch and activate Xcode 6.3.2 in El Capitan Developer Preview 2.

##How it works

It's simple, it just check if the Xcode process is running, if so; then activate the application. If Xcode isn't running, then launch it via the terminal workaround.

##Source

```applescript
on is_running(appName)
    tell application "System Events" to (name of processes) contains appName
end is_running

set xcodeRunning to is_running("Xcode")
    if xcodeRunning then
    tell application "Xcode"
        activate
    end tell
else
    do shell script "/Applications/Xcode.app/Contents/MacOS/Xcode </dev/null &>/dev/null &"
end if
```

## Contribute

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create pull request

## Who made this?

- Christoffer Winterkvist ([@zenangst](https://twitter.com/zenangst))

## Thanks

A big shout-out to [Sash Zats](https://twitter.com/zats), who made the initial [Xcode-Launcher](https://twitter.com/zats/status/613464620997570560) on which this is based.