THIS PACKAGE IS NOT BEING DEVELOPED ANYMORE AS THE ATOM EDITOR ITSELF NOW HAS THE SAME FUNCTIONALITY AND THIS PLUGIN WAS WRITTEN FOR A PREVIOUS VERSION OF ATOM. THIS PACKAGE IS NOT BEING SUPPORTED BY THE NEW ATOM VERSIONS AND WILL NOT WORK AT ALL!
===
For everyone who used this and wanted an update: I wanted to write something new and improved but this project is not needed anymore. Atom has now built-in functionality for this and they are probably doing it smoother. I created this project when I first got access to the Atom beta and it didn´t save my windows, workfolders or tabs. I wanted something that did this and while this was not the best solution it worked somewhat. Back then Atom was not entirely open sourced and the documentation was not very throughout so this became a very "hackish" solution to my problem by basically implementing basic website logic into the package. 

Anyway, I hope some people enjoyed this while it still worked and to all of you who have been frustrated with its inability to work with the newer versions of Atom I offer my deepest apologies. Developing this package was a great learning experience for me and my first contribution to any online project really but there´s no need for this package and therefore I feel that spending more time on this would be a waste! Thank you all.

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
