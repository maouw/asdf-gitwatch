#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for gitwatch.
GH_REPO="https://github.com/gitwatch/gitwatch"
TOOL_NAME="gitwatch"
TOOL_TEST="gitwatch"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if gitwatch is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# TODO: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if gitwatch has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	case "${ASDF_INSTALL_TYPE:-version}" in
	ref)
		url="$GH_REPO/archive/${version}.tar.gz"
		;;
	version)
		url="$GH_REPO/archive/v${version}.tar.gz"
		;;
	*)
		return 1
		;;
	esac

	echo "* Downloading $TOOL_NAME@$version from $url..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"
	local install_prefix
	install_prefix="$(dirname "${install_path}")"

	if [ "$install_type" != "version" ] && [ "$install_type" != "ref" ]; then
		fail "asdf-$TOOL_NAME supports release or ref installs only (got ASDF_INSTALL_TYPE=\"${ASDF_INSTALL_TYPE:-}\""
	fi

	(
		mkdir -p "${install_path}"
		cp -r "${ASDF_DOWNLOAD_PATH}"/* "${install_prefix}"
		(cd "${install_path}" && ln -s ../gitwatch.sh gitwatch)

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
