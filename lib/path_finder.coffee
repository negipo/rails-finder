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
    spec: ['spec', 'test']
    lib: ['lib']
    log: ['log']
    asset: ['app/assets']
    config: ['config']
    extension: ['app/extensions']
    batch: ['app/batches']
    root: ['']
  ignores: /(?:\/.git\/|\.keep$|\.DS_Store$|\.eot$|\.otf$|\.ttf$|\.woff$|\.png$|\.svg$|\.jpg$|\.gif$|\.mp4$|\.eps$|\.psd$)/

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

  getRailsRootPath: (candidatePath) ->
    children = _.map fs.listSync(candidatePath), (child) ->
      path.basename(child)

    isRailsRootPath = _.all @railsRootPathChildren, (railsRootPathChild) ->
      _.contains(children, railsRootPathChild)

    return candidatePath if isRailsRootPath
