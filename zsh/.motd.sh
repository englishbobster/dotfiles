#! /usr/bin/env zsh

#colours
autoload -U colors && colors

# * Current system uptime
uptime=$(/usr/bin/uptime)

# Any sneaky remote SSH logins:
logins=$(/usr/bin/users)

# lovely picture
echo "     $fg[red](\`-').-> (\`-')$fg[white]"
echo "     $fg[red]( $fg[yellow]OO$fg[red])_   ( $fg[yellow]OO$fg[red]).->        .->$fg[white]"
echo "    $fg[red](_)$fg[blue]--$fg[red]\\_)  /    '._   $fg[blue],--.$fg[red]($fg[blue],--.$fg[white]"
echo "    $fg[blue]/    _ /  |$fg[red]'--...__)$fg[blue] |  | |$fg[red](\`-')$fg[white]"
echo "    $fg[blue]\\_..\`--.  \`--.  .--' |  | |$fg[red]($fg[yellow]OO$fg[red] )$fg[white]"
echo "    $fg[blue].-._)   \\    |  |    |  | | $fg[red]|  \\$fg[white]"
echo "    $fg[blue]\\       /    |  |    \\  '-'$fg[red](_ .'$fg[white]"
echo "     $fg[blue]\`-----'     \`--'     \`-----'$fg[white]   "
echo $'\n'

echo "$fg[yellow]You never ever know...$fg[white]\n\n"

# Print some info
logins=("${(@f)$(/usr/bin/last -4 | /usr/bin/tail -3)}")
echo "$fg[green]Last logins:......$fg[white]"

for i in "${logins[@]}"
do
    echo "\t\t\t$i"
done
echo "\t\t\t$fg[green]-----------------------$fg[white]"
echo "\t\t\tnow $(whoami)"
echo "$fg[red]Uptime........: $uptime$fg[white]"
