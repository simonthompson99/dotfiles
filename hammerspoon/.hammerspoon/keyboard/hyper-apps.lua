-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.
--
-- hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end) gives list of application names
return {
 -- { 'c', 'Google Chrome' },     -- "c" for "Chrome"
  { 'b', 'Obsidian' },     -- "c" for "Chrome"
  { 'c', 'Firefox' },     -- "c" for "Chrome"
  { 'd', 'DBeaver' }, -- "D" for 'Data'
  { 'e', 'Mail' }, -- 'E' for email
  { 'x', 'Microsoft Excel' },              -- "x" for "eXcel"
  { 'f', 'Finder' },            -- "F" for "Finder"
  { 'l', 'Calendar' },            -- "L" for "caLendar"
  { 'm', 'Microsoft Teams (work or school)' },            -- "M" for "Microsoft"
  { 's', 'Slack' },             -- "S" for "Slack"
  { 'w', 'WorkFlowy' },             -- "W" for "WorkFlowy"
  { 't', 'iTerm' },             -- "T" for "Terminal"
  { 'p', 'Pocket Casts' },             -- "p" for "Pocketcasts"
  { 'o', 'Spotify' },             -- "o" for "SpOtify"
  { 'r', 'Firefox' },             -- "r" for "FiRefox"
}
