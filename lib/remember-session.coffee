{$} = require 'atom'

module.exports =

  activate: (state) ->
    if !newUser = !atom.config.get('remember-session.new')?
      restoreSession()
      atom.workspaceView.on('pane:active-item-changed', restoreTabs)
      $(window).on 'ready', -> restoreTreeView()

    $(window).on 'resize', -> saveDimensions()
    $(window).on 'beforeunload', -> saveSession()
    atom.config.set('remember-session.new', false)

    if newUser
      windows = 1
    else
      windows = atom.config.getInt('remember-session.windows')
      windows++
    atom.config.set('remember-session.windows', windows)

saveDimensions = ->
  {x, y, width, height} = atom.getWindowDimensions()
  treeWidth = $('.tree-view-resizer').width()
  console.log(width)

  atom.config.set('remember-session.x', x)
  atom.config.set('remember-session.y', y)
  atom.config.set('remember-session.width', width)
  atom.config.set('remember-session.height', height)
  atom.config.set('remember-session.treeWidth', treeWidth)

saveSession = ->
  if (windows = atom.config.get('remember-session.windows')) != 1
    return
  windows--
  atom.config.set('remember-session.windows', windows)

  atom.config.set('remember-session.path', atom.project.getPath())
  tabs = ''
  atom.workspace.eachEditor((editor) ->
    if editor.getPath()?
  	  tabs += "&&" + editor.getPath()
  )
  tabs = tabs.substr(2)
  atom.config.set('remember-session.tabs', tabs)

restoreSession = ->
  if (windows = atom.config.get('remember-session.windows')) != 0
    return
  {x, y, width, height, path} = atom.config.get('remember-session')
  if path? and path != '' and path != '.'
    atom.project.setPath(path)
    atom.config.set('remember-session.path', '')
  atom.setWindowDimensions
    'x':x
    'y':y
    'width':width
    'height':height

restoreTabs = (event, pane) ->
  tabs = atom.config.get('remember-session.tabs').split('&&')
  atom.workspace.getActivePane().destroyItem(pane)
  atom.workspaceView.off('pane:active-item-changed', restoreTabs)
  for tab in tabs
    atom.workspace.open(tab)
  atom.config.set('remember-session.tabs', '')

restoreTreeView = ->
  treeWidth = atom.config.get('remember-session.treeWidth')
  $('.tree-view-resizer').width(treeWidth)
