dotfiles
========

My dotfiles, managed via homesick: <https://github.com/technicalpickles/homesick>

## Update

```bash
cd $(homesick show_path)
git pull
git submodule foreach git pull origin master
homesick rc
```