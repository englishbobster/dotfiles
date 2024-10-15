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

echo "$fg[yellow]
WIIO's LAWS
===========
The fundamental Wiio's law states that "Communication usually fails, except by accident". The full set of laws is as follows:

1. Communication usually fails, except by accident.
	a. If communication can fail, it will.
	b. If communication cannot fail, it still most usually fails.
	c. If communication seems to succeed in the intended way, there's a misunderstanding.
	d. If you are content with your message, communication certainly fails.
2. If a message can be interpreted in several ways, it will be interpreted in a manner that maximizes the damage.
3. There is always someone who knows better than you what you meant with your message.
4. The more we communicate, the worse communication succeeds.
	a.The more we communicate, the faster misunderstandings propagate.
5. In mass communication, the important thing is not how things are but how they seem to be.
6. The importance of a news item is inversely proportional to the square of the distance.
7. The more important the situation is, the more probable you had forgotten an essential thing that you remembered a moment ago.

$fg[white]\n\n"

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
