set audio to ""
set video to ""

if application "zoom.us" is running then
  tell application "System Events"
    tell application process "zoom.us"
      if exists (menu item "Stop Video" of menu 1 of menu bar item "Meeting" of menu bar 1) then
        set video to "V"
      end if
      if exists (menu item "Mute audio" of menu 1 of menu bar item "Meeting" of menu bar 1) then
        set audio to "A"
      end if
    end tell
  end tell
end if

return audio & video
