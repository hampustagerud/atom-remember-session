{$} = require 'atom'

module.exports =

  activate: (state) ->
    restoreSession()
    atom.workspaceView.on('pane:active-item-changed', restoreTabs)
    $(window).on 'rezize', -> saveDimensions()
    $(window).on 'beforeunload', -> saveSession()

saveDimensions = ->
  {x, y, width, height} = atom.getWindowDimensions()
  treeWidth = $('.tree-view-resizer').width()

  atom.config.set('remember-session.x', x)
  atom.config.set('remember-session.y', y)
  atom.config.set('remember-session.width', width)
  atom.config.set('remember-session.height', height)
  atom.config.set('remember-session.treeWidth', treeWidth)

saveSession = ->
  saveDimensions()
  atom.config.set('remember-session.path', atom.project.getPath())
  tabs = ''
  atom.workspace.eachEditor((editor) ->
    if typeof editor.getPath() isnt 'undefined'
  	  tabs += "&&" + editor.getPath()
  )
  tabs = tabs.substr(2)
  atom.config.set('remember-session.tabs', tabs)

restoreSession = ->
  {x, y, width, height, treeWidth, path} = atom.config.get('remember-session')
  $('.tree-view-resizer').width(treeWidth)
  atom.setWindowDimensions
    'x':x
    'y':y
    'width':width
    'height':height
  if path? and path isnt ''
    atom.project.setPath(path)
  atom.config.set('remember-session.path', '')

restoreTabs = (event, pane) ->
  tabs = atom.config.get('remember-session.tabs').split('&&')
  atom.workspace.getActivePane().destroyItem(pane)
  atom.workspaceView.off('pane:active-item-changed', restoreTabs)
  for tab in tabs
    atom.workspace.open(tab)
  atom.config.set('remember-session.tabs', '')
