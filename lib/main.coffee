{CompositeDisposable} = require 'atom'
PathFinder = require './path_finder'

module.exports =
  config:
    controllerPathes:
      description: 'Array of controller path.'
      type: 'array'
      default: ['app/controllers']
      items:
        type: 'string'
    modelPathes:
      description: 'Array of model path.'
      type: 'array'
      default: ['app/models']
      items:
        type: 'string'
    viewPathes:
      description: 'Array of view path.'
      type: 'array'
      default: ['app/views']
      items:
        type: 'string'
    helperPathes:
      description: 'Array of helper path.'
      type: 'array'
      default: ['app/helpers']
      items:
        type: 'string'
    mailerPathes:
      description: 'Array of mailer path.'
      type: 'array'
      default: ['app/mailers']
      items:
        type: 'string'
    dbPathes:
      description: 'Array of db path.'
      type: 'array'
      default: ['db']
      items:
        type: 'string'
    specPathes:
      description: 'Array of spec path.'
      type: 'array'
      default: ['spec', 'test']
      items:
        type: 'string'
    libPathes:
      description: 'Array of lib path.'
      type: 'array'
      default: ['lib']
      items:
        type: 'string'
    logPathes:
      description: 'Array of log path.'
      type: 'array'
      default: ['log']
      items:
        type: 'string'
    assetPathes:
      description: 'Array of asset path.'
      type: 'array'
      default: ['app/assets']
      items:
        type: 'string'
    configPathes:
      description: 'Array of config path.'
      type: 'array'
      default: ['config']
      items:
        type: 'string'
    extensionPathes:
      description: 'Array of extension path.'
      type: 'array'
      default: ['app/extensions']
      items:
        type: 'string'
    batchPathes:
      description: 'Array of batch path.'
      type: 'array'
      default: ['app/batchs']
      items:
        type: 'string'
    localePathes:
      description: 'Array of locale path.'
      type: 'array'
      default: ['app/locales']
      items:
        type: 'string'
    rootPathes:
      description: 'Array of root path.'
      type: 'array'
      default: ['']
      items:
        type: 'string'

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
      'rails-finder:toggle-locale': =>
        @getPathes('locale')
      'rails-finder:toggle-root': =>
        @getPathes('root')

  deactivate: ->
    if @view?
      @view.destroy()
      @view = null
    @subscriptions.dispose()

  getPathes: (key) ->
    return unless @pathFinder()
    @getView().toggle(@pathFinder().getPathes(key))

  getView: ->
    @view ?= new (require './view')

  pathFinder: ->
    return unless @currentPath()
    new PathFinder(@currentPath())

  currentPath: ->
    textEditor = atom.workspace.getActiveTextEditor()
    return unless textEditor
    textEditor.getPath()
