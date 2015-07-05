path = require 'path'
fs = require 'fs-plus'
_  = require 'underscore-plus'

module.exports =
class PathFinder
  railsRootPathChildren: ['app', 'config', 'lib']
  rootPathes:
    controller: ['app/controllers']
    model: ['app/models']
    view: ['app/views']
    helper: ['app/helpers']
    mailer: ['app/mailers']
    db: ['db']
    spec: ['spec']
    lib: ['lib']
    log: ['log']
    asset: ['app/assets']
    config: ['config']
    root: ['']
  ignores: /(?:\/.git\/|\.keep$)/

  constructor: (currentPath) ->
    @railsRootPath = @getRailsRootPath(currentPath)

  getPathes: (key) ->
    return [] unless @railsRootPath

    pathes = []
    for relativeRootPath in @rootPathes[key]
      rootPath = path.join(@railsRootPath, relativeRootPath)
      appendPathes = _.filter(fs.listTreeSync(rootPath), (candidatePath) =>
        fs.isFileSync(candidatePath) && !@ignores.test(candidatePath)
      )
      pathes = pathes.concat(appendPathes)

    return _.uniq(pathes)

  getRailsRootPath: (currentPath) ->
    return @railsRootPath if @railsRootPath?

    candidatePath = path.dirname(currentPath)
    while candidatePath != '/'
      candidatePath = path.resolve(path.join(candidatePath, '..'))

      children = _.map(fs.listSync(candidatePath), (child) ->
        path.basename(child)
      )
      israilsRootPath = _.all(@railsRootPathChildren, (railsRootPathChild)->
        _.contains(children, railsRootPathChild)
      )
      if israilsRootPath
        @railsRootPath = candidatePath
        return @railsRootPath
