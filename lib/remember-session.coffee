{$} = require 'atom'

module.exports =
  activate: (state) ->
    attachListeners()

    if atom.project.getPath()?
      restoreDimensions()
      return

    if atom.config.get('remember-session.path')? or atom.config.get('remember-session.tabs')?
      restoreSession()
      atom.workspaceView.on('pane:active-item-changed', selectTab)
      $(window).on 'ready', -> restoreTreeView()
      $(window).on 'ready', -> restoreTabs()

attachListeners = ->
  console.log 'Attatch listeners'
  $(window).on 'resize', -> saveDimensions()
  $(window).on 'beforeunload', -> saveSession()

saveDimensions = ->
  console.log 'Save dimensions'
  {x, y, width, height} = atom.getWindowDimensions()
  treeWidth = $('.tree-view-resizer').width()

  atom.config.set('remember-session.x', x)
  atom.config.set('remember-session.y', y)
  if width > 0
    atom.config.set('remember-session.width', width)
  if height > 0
    atom.config.set('remember-session.height', height)
  atom.config.set('remember-session.treeWidth', treeWidth)
  $(window).off 'beforeunload', -> saveSession()

saveSession = ->
  console.log 'Save session'
  if atom.project.getPath()?
    atom.config.set('remember-session.path', atom.project.getPath())
  atom.config.set('remember-session.x', atom.getWindowDimensions().x)
  atom.config.set('remember-session.y', atom.getWindowDimensions().y)

  tabs = ''
  selTab = 0
  atom.workspace.eachEditor((editor) ->
    if editor.getPath()?
      tabs += "&&" + editor.getPath()
    else
      return true
  )
  selectedTab = 0
  $('.tab-bar').children('li').each(()->
    if $(this).hasClass('active')
      atom.config.set('remember-session.selectedTab', selectedTab)
    selectedTab++
  )
  tabs = tabs.substr(2)
  atom.config.set('remember-session.tabs', tabs)
  return true

restoreSession = ->
  console.log 'Restore session'
  if (path = atom.config.get('remember-session.path'))? and path isnt ''
    atom.project.setPath(atom.config.get('remember-session.path'))
    atom.config.set('remember-session.path', '')
  restoreDimensions()

restoreDimensions = ->
  console.log 'Restore dimensions'
  {x, y, width, height, path} = atom.config.get('remember-session')
  atom.setWindowDimensions
    'x': x
    'y': y
    'width': width
    'height': height

restoreTabs = ->
  console.log 'Restore tabs'
  tabs = atom.config.get('remember-session.tabs').split('&&')
  for tab in tabs
    atom.workspace.open(tab)
  $(window).off 'ready', -> restoreTabs()

selectedIndex = 0
selectTab = (event, item) ->
  console.log 'Select tab'
  tabs = atom.config.get('remember-session.tabs').split('&&').clean('')
  if tabs.length > 0 and !item.getPath()?
    atom.workspace.getActivePane().destroyItem(item)
  if atom.workspace.getActiveEditor()? and atom.workspace.getActiveEditor().getPath() == tabs[tabs.length - 1]
    $('.tab-bar').children('li').each(()->
      selectedTab = atom.config.get('remember-session.selectedTab')
      if selectedIndex == selectedTab
        $(this).addClass('active')
      else
        $(this).removeClass('active')
      selectedIndex++
    )
    selectedIndex = -1
    $('.item-views').children('div').each(()->
      selectedTab = atom.config.get('remember-session.selectedTab')
      if selectedIndex == selectedTab
        $(this).css('display', 'flex')
      else
        $(this).css('display', 'none')
      selectedIndex++
    )

    atom.config.set('remember-session.selectedTab', '')
    atom.config.set('remember-session.tabs', '')
    atom.workspaceView.off('pane:active-item-changed', selectTab)

restoreTreeView = ->
  console.log 'Restore treeview'
  treeWidth = atom.config.get('remember-session.treeWidth')
  $('.tree-view-resizer').width(treeWidth)
  $(window).off 'ready', -> restoreTreeView()

Array.prototype.clean = (deleteValue) ->
  for i in [0..this.length]
    if (this[i] == deleteValue)
      this.splice(i, 1);
      i--;
  return this;
