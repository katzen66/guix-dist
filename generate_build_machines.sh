#! /bin/sh
echo -n "(list "
while IFS= read -r line; do
	echo
	echo -e "\t(build-machine"
	echo $line|awk '{print "\t(name \""$1"\")"}'
	echo -e -n "\t(systems (list"; cat $(echo $line | awk '{print $1"_arch"}') | awk '{for (i = 1; i <= NF; i++) printf " \""$i"\""}'; echo "))"
	echo -e -n "\t(host-key \""; echo $line | awk '{printf $2" "$3}'; echo ")"
	echo -e "\t(user \"guix-dist\")"
	echo -e "\t(private-key \"/opt/guix-dist/key.priv))"
done < known_hosts
echo ")"
