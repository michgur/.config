tell application "Safari"
set currentWindows to every window
set activeWindowName to name of first window
set activeProfile to word 1 of activeWindowName
repeat with i from 2 to count of currentWindows
set thisWindowName to name of item i of currentWindows
set thisProfile to word 1 of thisWindowName
if thisProfile is not equal to activeProfile then
set index of item i of currentWindows to 1
exit repeat
end if
end repeat
end tell

