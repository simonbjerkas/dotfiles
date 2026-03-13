ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)

typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[comment]='fg=#666666'

ZSH_HIGHLIGHT_STYLES[alias]='fg=#FABF47'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#FABF47'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#FABF47'
ZSH_HIGHLIGHT_STYLES[function]='fg=#FABF47'
ZSH_HIGHLIGHT_STYLES[command]='fg=#FABF47'

ZSH_HIGHLIGHT_STYLES[precommand]='fg=#BEFF00,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#00FFF5,italic'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#BEFF00'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#BEFF00'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#a07d3a'

ZSH_HIGHLIGHT_STYLES[builtin]='fg=#00FFF5'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#FABF47'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#00FFF5'

ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FF807F'

ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#CCCCCC'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#CCCCCC'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#CCCCCC'

ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#FF807F,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#FF807F,bold'

ZSH_HIGHLIGHT_STYLES[path]='fg=#ffffff'

ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#fdf4c1'

ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF807F,bold'

ZSH_HIGHLIGHT_STYLES[cursor]='fg=#111111,bg=#FABF47'

# LS_COLORS for to match output of different CLI's such as `eza`, `git` etc.
export LS_COLORS='\
rs=0:\
fi=0:\
di=1;36:\
ln=1;96:\
mh=00:\
pi=33:\
so=1;35:\
do=1;35:\
bd=1;33:\
cd=1;33:\
or=1;31:\
mi=1;31:\
su=1;31:\
sg=1;33:\
ca=30;43:\
tw=30;42:\
ow=34;42:\
st=37;44:\
ex=1;32:\
*.7z=1;33:\
*.apk=1;33:\
*.arc=1;33:\
*.arj=1;33:\
*.bz2=1;33:\
*.cab=1;33:\
*.cpio=1;33:\
*.deb=1;33:\
*.dmg=1;33:\
*.gz=1;33:\
*.iso=1;33:\
*.jar=1;33:\
*.lz=1;33:\
*.lz4=1;33:\
*.lzh=1;33:\
*.lzma=1;33:\
*.rar=1;33:\
*.rpm=1;33:\
*.tar=1;33:\
*.tbz=1;33:\
*.tgz=1;33:\
*.tlz=1;33:\
*.txz=1;33:\
*.tz=1;33:\
*.tzo=1;33:\
*.xz=1;33:\
*.z=1;33:\
*.zip=1;33:\
*.zst=1;33:\
*.jpg=38;5;223:\
*.jpeg=38;5;223:\
*.png=38;5;223:\
*.gif=38;5;223:\
*.bmp=38;5;223:\
*.webp=38;5;223:\
*.svg=38;5;159:\
*.mp4=38;5;179:\
*.mkv=38;5;179:\
*.avi=38;5;179:\
*.mov=38;5;179:\
*.mp3=38;5;151:\
*.flac=38;5;151:\
*.wav=38;5;151:\
*.ogg=38;5;151:\
*.opus=38;5;151:\
*.pdf=1;31:\
*.md=38;5;223:\
*.txt=0:\
*.log=38;5;243:\
*.rs=38;5;222:\
*.go=38;5;51:\
*.c=37:\
*.h=37:\
*.cpp=37:\
*.hpp=37:\
*.py=38;5;222:\
*.js=38;5;222:\
*.ts=38;5;81:\
*.tsx=38;5;81:\
*.jsx=38;5;222:\
*.lua=38;5;81:\
*.nix=38;5;151:\
*.zig=38;5;209:\
*.toml=38;5;223:\
*.yaml=38;5;223:\
*.yml=38;5;223:\
*.json=38;5;223:\
*.lock=38;5;243'

# `bat` specific exports
export BAT_THEME="ansi"
export BAT_STYLE="numbers,changes,header"
