const path = require('path');
const pkgRoot = atom.packages.resolvePackagePath('fuzzy-finder');
const FuzzyFinderView = require(path.join(pkgRoot, 'lib', 'fuzzy-finder-view'));

module.exports =
class View extends FuzzyFinderView {
  getEmptyMessage() {
    return 'No files here';
  }

  async toggle(items) {
    if (this.panel != null ? this.panel.isVisible() : undefined) {
      this.cancel();
    } else {
      this.show();
      await this.setItems(this.projectRelativePathsForFilePaths(items))
    }
  }
};
