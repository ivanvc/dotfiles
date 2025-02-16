#!/bin/bash
# vim: set noexpandtab:

export AWS_PAGER=
if command -v aws_completer &>/dev/null; then
	complete -C aws_completer aws
fi
