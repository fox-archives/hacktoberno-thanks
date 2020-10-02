#!/bin/sh

# set -euo pipefail

# sudo apt-get update \
# 	&& apt-get install --no-install-recommends -y jq ca-certificates

# informative
# jq ".pull_request.head.label" < "$GITHUB_EVENT_PATH" \
	# | xargs printf "DOING FOR '%s'"
printf "merging head repo '%s' into base '%s'" "$GITHUB_HEAD_REF" "$GITHUB_BASE_REF"

# htmlUrl="$(jq ".pull_request.head.repo.html_url" < "$GITHUB_EVENT_PATH")"
htmlUrl="$GITHUB_HEAD_REF"

git clone htmlUrl \
	--depth 2 "$htmlUrl"
cd "${htmlUrl##*/}"

ls -al

# see most recent changes
changes="$(git diff-index --color=always -M -C -p HEAD~1 \
	| grep $'^\033\[3[12]m' \
	| sed -r 's/\x1b\[[0-9;]*m?//g' >recent-changes)"

# basic test
case "$changes" in
	*awesome*)
		echo "UH OH"
		exit 1
		;;
	*)
		exit 0
		;;
esac

perl -h
