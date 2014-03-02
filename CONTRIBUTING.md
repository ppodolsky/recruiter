Contributing
================================================================================
Development should be done on local branches only. Incoming patches come to
`develop`. Stable branches will be tagged as such. If working collaboratively on
some changes, use feature branches. Create a feature branch and check it out to
start working, like so:

    git checkout -b feature/abc-new-feature # your initials instead of 'abc'

Feature branches should be published to the remote, like so:

    git push origin feature/abc-new-feature

To checkout a new remote, do this:

    git checkout feature/abc-new-feature
    git branch --set-upstream  origin/feature/abc-new-feature

Rebase instead of merging on published branches to keep history clean and
readable.

    # on your local working branch
    git checkout my-branch
    git rebase my-branch

Contributions should be rebased with `origin/develop` before submitting for
review. That is, `git pull --rebase` on `develop`, then rebase with `develop`
from your working branch and use `git mergetool` to resolve conflicts before
issuing a pull request or submitting a patch.

Here are some more tips for [working with remotes](http://www.gitguys.com/topics/adding-and-removing-remote-branches/).

Style
================================================================================
Please conform to the [ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)
on Github. Basics:
  - no tabs, 2 spaces
  - inline blocks should have padding of one space between opening and closing
    curly bracket

Additionally, prefer 80 columns for wrapping documentation and comments. Code
does not have to be wrapped, unless it improves readability. Code should be
aligned logically, however. There are plugins available for your favorite editor
that should make this painless.

``` ruby
# not aligned
gem 'pg' # datastore
gem 'unicorn' # server
gem 'responders' # flash messages
gem 'high_voltage' # static pages

# aligned
gem 'pg'           # datastore
gem 'unicorn'      # server
gem 'responders'   # flash messages
gem 'high_voltage' # static pages
```
