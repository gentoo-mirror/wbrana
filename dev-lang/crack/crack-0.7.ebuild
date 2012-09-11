EAPI="4"
inherit eutils flag-o-matic multilib pax-utils

DESCRIPTION="Crack language compiler, virtual machine, library"
HOMEPAGE="http://www.crack-lang.org/"
SRC_URI="https://crack-language.googlecode.com/files/${PN}-${PV}.tar.gz"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="MPL-2.0"

src_prepare() {
	epatch "${FILESDIR}/crack-nopie.patch"
}

src_compile() {
	make -j2 CXXFLAGS="-g -O3 -march=native -fomit-frame-pointer -funroll-loops --param max-unrolled-insns=64 -fno-PIE -fPIC"
	pax-mark m .libs/crack
}

src_install() {
	make DESTDIR="${D}" install
}
