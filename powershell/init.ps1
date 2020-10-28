Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install sudo
scoop bucket add extras
scoop install concfg
scoop install posh-git
scoop install oh-my-posh
Install-Module Get-ChildItemColor -AllowClobber -Proxy http://127.0.0.1:10809