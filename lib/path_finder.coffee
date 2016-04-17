path = require 'path'
fs = require 'fs-plus'
_  = require 'underscore-plus'

module.exports =
class PathFinder
  railsRootPathChildren: ['app', 'config', 'lib']
  ignores: /(?:\/.git\/|\.keep$|\.DS_Store$|\.eot$|\.otf$|\.ttf$|\.woff$|\.png$|\.svg$|\.jpg$|\.gif$|\.mp4$|\.eps$|\.psd$)/

  constructor: (currentPath) ->
    @railsRootPath = @getRailsRootPath(currentPath)

  getPathes: (key) ->
    return [] unless @railsRootPath

    pathes = []
    for relativeRootPath in atom.config.get("rails-finder.#{key}Pathes")
      rootPath = path.join(@railsRootPath, relativeRootPath)
      appendPathes = _.filter(fs.listTreeSync(rootPath), (candidatePath) =>
        fs.isFileSync(candidatePath) && !@ignores.test(candidatePath)
      )
      pathes = pathes.concat(appendPathes)

    return _.uniq(pathes)

  getRailsRootPath: (currentPath) ->
    candidatePath = path.dirname(currentPath)
    while candidatePath != '/'
      candidatePath = path.resolve(path.join(candidatePath, '..'))

      children = _.map(fs.listSync(candidatePath), (child) ->
        path.basename(child)
      )
      isRailsRootPath = _.all(@railsRootPathChildren, (railsRootPathChild)->
        _.contains(children, railsRootPathChild)
      )
      if isRailsRootPath
        return candidatePath
    return atom.project.rootDirectories[0].path
