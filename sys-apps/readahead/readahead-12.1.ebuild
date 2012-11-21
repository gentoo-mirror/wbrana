# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
SCONS_MIN_VERSION="2.2"

inherit scons-utils toolchain-funcs

DESCRIPTION="ahead file reader for ext4 compatible filesystems"
HOMEPAGE="http://sourceforge.net/projects/readahead/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	>=x11-libs/qt-core-4.8:4
"

DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.6
	virtual/pkgconfig
"

pkg_setup() {
	if [[ ${MERGE_TYPE} != "binary" ]]; then
		local major=$(gcc-major-version)
		local minor=$(gcc-minor-version)
		if (( major < 4 || ( major == 4 && minor < 6 ) )); then
			die "gcc 4.6 or newer is required"
		fi
	fi
}

src_configure() {
	myesconsargs=(
		env=1
		final=1
		$(use_scons debug)
	)
}

src_compile() {
	escons
}

src_install() {
	escons prefix="${D}" install
	newinitd init.d/readahead readahead
}

pkg_postinst() {
	rc-config add readahead boot
}

pkg_prerm() {
	rc-config delete readahead boot
}
