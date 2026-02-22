on run argv
  if (count of argv) < 2 then
    error "Usage: add_note.applescript <title> <body>"
  end if

  set noteTitle to item 1 of argv
  set noteBody to item 2 of argv

  tell application "Notes"
    -- Create in the first folder of the first account.
    make new note at folder 1 of account 1 with properties {name:noteTitle, body:noteBody}
  end tell
end run
