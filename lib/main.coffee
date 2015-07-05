{CompositeDisposable} = require 'atom'
PathFinder = require './path_finder'

module.exports =
  activate: (state) ->
    @subscriptions = new CompositeDisposable

    atom.commands.add 'atom-workspace',
      'rails-finder:toggle-controller': =>
        @getView().toggle(@pathFinder().getPathes('controller'))
      'rails-finder:toggle-model': =>
        @getView().toggle(@pathFinder().getPathes('model'))
      'rails-finder:toggle-view': =>
        @getView().toggle(@pathFinder().getPathes('view'))
      'rails-finder:toggle-helper': =>
        @getView().toggle(@pathFinder().getPathes('helper'))
      'rails-finder:toggle-mailer': =>
        @getView().toggle(@pathFinder().getPathes('mailer'))
      'rails-finder:toggle-db': =>
        @getView().toggle(@pathFinder().getPathes('db'))
      'rails-finder:toggle-log': =>
        @getView().toggle(@pathFinder().getPathes('log'))
      'rails-finder:toggle-spec': =>
        @getView().toggle(@pathFinder().getPathes('spec'))
      'rails-finder:toggle-lib': =>
        @getView().toggle(@pathFinder().getPathes('lib'))
      'rails-finder:toggle-asset': =>
        @getView().toggle(@pathFinder().getPathes('asset'))
      'rails-finder:toggle-config': =>
        @getView().toggle(@pathFinder().getPathes('config'))
      'rails-finder:toggle-root': =>
        @getView().toggle(@pathFinder().getPathes('root'))

  deactivate: ->
    if @view?
      @view.destroy()
      @view = null
    @subscriptions.dispose()

  getView: ->
    @view ?= new (require './view')

  pathFinder: ->
    new PathFinder(@currentPath())

  currentPath: ->
    atom.workspace.getActiveTextEditor().getPath()
