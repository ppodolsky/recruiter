Contributing
================================================================================
Development should be done on local branches only. Incoming patches come to
`master`. Stable branches will be tagged as such. If working collaboratively on
some changes, use feature branches. Create a feature branch and check it out to
start working, like so:

    git checkout -b f-my-new-feature # include prepended `f-`

Feature branches should be published to the remote, like so:

    git push origin f-my-new-feature

To checkout a new remote, do this:

    git checkout f-my-new-feature
    git branch --set-upstream f-my-new-feature origin/f-my-new-feature

Rebase instead of merging on published branches to keep history clean and
readable.

    # on your local working branch
    git checkout my-branch
    git rebase my-branch

Contributions should be rebased with `origin/master` before submitting for
review. That is, rebase with `master` branch and use `git mergetool` to resolve
conflicts before issuing a pull request or submitting a patch.

Finally, there are several slave branches used for publishing. These branches
contain customizations for several deployments. These should be sent to staging
before deploying. So the workflow looks like:

    +-> make some local changes
    |             +
    |             |
    |             v
    |    +---------------+
    |    |     rebase    |
    |    |---------------|                                            +--------------------+
    |    | origin/master |                                            |       rebase       |
    |    +---------------+                                PUSH IT! <-+|--------------------|
    |             +                                                   | origin/slave-brand |
    |             |                                                   +--------------------+
    |             v                                                              ^
    |    +---------------+                                                       |
    |    | pull request  |                           +----------------+          +
    |    |---------------|+-> review +-> accepted +->|     rebase     |+-> if deploying
    |    | origin/master |      +                    |----------------|
    |    +---------------+      |                    | origin/staging |
    |                           v                    +----------------+
    |                         reject
    |                           +
    |                           |
    +---------------------------+

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
