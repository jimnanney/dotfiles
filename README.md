Use GNU stow to manage the dotfiles

To install GNU Stow on mac, use homebrew

```
brew install stow
```

Install each package individually with

```
stow <package name>
```

Or all at once with

```
stow `ls -d */`
```

If you wish to also have a separate repo for other stowed files, you must include a `.stow` file at the root of each repo.

For example, I have a dotfiles and dotfiles-work repo. To install all the packages from both cd into those directories and issues the install all command as above.

```
cd ~/dotfiles
stow `ls -d */`
cd ~/dotfiles-work
stow `ls -d */`
```

