#!/bin/bash
# vim: set noexpandtab:

ave() {
	if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "help" ] || [ -z "$1" ]; then
		cat <<- EOF
		Usage: ave [-l/--list] profile [duration]

		-l/--list: List the available AWS profiles from ~/.aws/config.
		profile:   The name of the profile in your ~/.aws/config file to assume.
		duration:  The desired duration for the temporary keys before they expire,
		           i.e., 5m, 1h, 24h (default: 3h).
		EOF
		return
	fi
	if [ "$1" = "-l" ] || [ "$1" = "--list" ]; then
		echo Available AWS profiles:
		awk '/^\[profile/{print gensub(/^\[profile ([^\]]*)]/, "\t\\1", "g", $0);}' "$HOME/.aws/config" | sort
		return
	fi

	local profile="$1"
	shift
	local duration="$1"
	[ -z "$duration" ] && duration=3h
	local macos
	[ "$(uname -s)" = "Darwin" ] && macos="yes"

	case "$profile" in
		root|mgmt) profile=management ;;
		dev) profile=development ;;
		stg) profile=staging ;;
		prod) profile=production ;;
		ev) profile=eyeview ;;
		sn) profile=social_next ;;
	esac

	[ -n "$AWS_VAULT" ] && unset AWS_VAULT

	eval "$(aws-vault exec -d"$duration" "$profile" env | grep AWS_ | xargs -I{} ${macos:+"-S1024"} echo export {})"
}

unave() {
	local macos
	[ "$(uname -s)" = "Darwin" ] && macos="yes"

	eval "$(env | grep AWS_ | xargs -I{} ${macos:+"-S1024"} echo unset {})"
}
