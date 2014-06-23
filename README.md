## Remember Session

A simple package to save your session when you close Atom.  
Based on
[AbeEstradas remember-window](https://github.com/AbeEstrada/atom-remember-window)

### Install
`apm install remember-session`

### Features
*   Saves window location, size along with tree-view width
*   Saves the project path and redirects your next session to that path
*   Stores all your open tabs and which tab was selected

### Current limitations (to be implemented):
*   Only the session from the window closed last is saved at the moment
*   Only the active pane is saved
*   ~~Selected tab is not saved~~ (implemented as of 0.4.0)

### Changelog
*	Version 0.5.1
	-	Fixed a bug that caused Atom to not quit properly
*   Version 0.5.0
    -   Fixed bugs that broke all functionality
*   Version 0.4.0
    +   Package now remembers which tab was active
    +   Package now handles opening multiple projects better
        (still only saves the one closed last)
    -   Fixed a bug where tabs wasn't reopened
    -   Crashes should not affect the functionality at the next restart  
        (saves will probably be lost but a bug prevented new saves after a crash)
    -   Opening new files from the tree view should now work properly again
*   Version 0.3.0
    +   Fixed some more bugs
*   Version 0.2.0
    +   Fixed some bugs
*   Version 0.1.0
    +   Initial commit
