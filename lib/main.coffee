{CompositeDisposable} = require 'atom'
PathFinder = require './path_finder'

module.exports =
  activate: (state) ->
    @subscriptions = new CompositeDisposable

    atom.commands.add 'atom-workspace',
      'rails-finder:toggle-controller': =>
        @getPathes('controller')
      'rails-finder:toggle-model': =>
        @getPathes('model')
      'rails-finder:toggle-view': =>
        @getPathes('view')
      'rails-finder:toggle-helper': =>
        @getPathes('helper')
      'rails-finder:toggle-mailer': =>
        @getPathes('mailer')
      'rails-finder:toggle-db': =>
        @getPathes('db')
      'rails-finder:toggle-log': =>
        @getPathes('log')
      'rails-finder:toggle-spec': =>
        @getPathes('spec')
      'rails-finder:toggle-lib': =>
        @getPathes('lib')
      'rails-finder:toggle-asset': =>
        @getPathes('asset')
      'rails-finder:toggle-config': =>
        @getPathes('config')
      'rails-finder:toggle-extension': =>
        @getPathes('extension')
      'rails-finder:toggle-batch': =>
        @getPathes('batch')
      'rails-finder:toggle-root': =>
        @getPathes('root')

  deactivate: ->
    if @view?
      @view.destroy()
      @view = null
    @subscriptions.dispose()

  getPathes: (key) ->
    return unless @pathFinder()

    if (@previousKey isnt key) and @getView().isVisible()
      @getView().setItems(@pathFinder().getPathes(key))
    else
      @getView().toggle(@pathFinder().getPathes(key))

    @previousKey = key

  getView: ->
    @view ?= new (require './view')

  pathFinder: ->
    # TODO: It's possiable to have more than one folder in a project
    new PathFinder(atom.project.getPaths()[0])
