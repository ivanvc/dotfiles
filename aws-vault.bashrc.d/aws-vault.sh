#!/bin/bash
# vim: set noexpandtab:

ave() {
	if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "help" ]; then
		cat <<- EOF
		Usage: ave profile [duration]
		
		profile:  The name of the profile in your ~/.aws/config file to assume.
		duration: The desired duration for the temporary keys before they expire,
		          i.e., 5m, 1h, 24h (default: 3h).
		EOF
		return
	fi

	local profile="$1"
	shift
	local duration="$1"
	[ -z "$duration" ] && duration=3h
	local macos
	[ "$(uname -s)" = "Darwin" ] && macos="yes"

	[ -n "$AWS_VAULT" ] && unset AWS_VAULT

	echo eval "$(aws-vault exec -d"$duration" "$profile" env | grep AWS_ | xargs -I{} ${macos:+"-S1024"} echo export {})"
}

unave() {
	local macos
	[ "$(uname -s)" = "Darwin" ] && macos="yes"

	eval "$(env | grep AWS_ | xargs -I{} ${macos:+"-S1024"} echo unset {})"
}
