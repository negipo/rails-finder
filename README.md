# rails-finder
![](https://dl.dropboxusercontent.com/u/275354/g/bbf0e9e9ceddb003af3bdfa025729f8c.gif)

Atom package to enable fuzzy find with rails project.
Note that you cannot open select list view while you are not opening a file in rails project, because this package search rails project dynamically for the current active file path.

# Keymap
No default keymaps. You can add on `keymap.cson` like this.

```
'atom-workspace':
  'ctrl-o c': 'rails-finder:toggle-controller'
  'ctrl-o m': 'rails-finder:toggle-model'
  'ctrl-o v': 'rails-finder:toggle-view'
  'ctrl-o h': 'rails-finder:toggle-helper'
  'ctrl-o i': 'rails-finder:toggle-mailer'
  'ctrl-o s': 'rails-finder:toggle-spec'
  'ctrl-o l': 'rails-finder:toggle-lib'
  'ctrl-o a': 'rails-finder:toggle-asset'
  'ctrl-o o': 'rails-finder:toggle-config'
  'ctrl-o d': 'rails-finder:toggle-db'
  'ctrl-o g': 'rails-finder:toggle-log'
  'ctrl-o r': 'rails-finder:toggle-root'
```

# Contributors
- xtr3me
- shemerey

# Acknowledgements
Some part of codes are based on [atom-recent-finder](https://github.com/t9md/atom-recent-finder).
Most of the features are based on [unite-rails](https://github.com/basyura/unite-rails) for vim.
