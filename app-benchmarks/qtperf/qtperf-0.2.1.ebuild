EAPI="4"
inherit multilib qt4-r2

DESCRIPTION="Qt graphics benchmark"
HOMEPAGE="http://code.google.com/p/qtperf/"
SRC_URI="http://qtperf.googlecode.com/files/${PN}-${PV}.tar.gz"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="GPL-3"
S="${WORKDIR}/${PN}"

DEPEND="
        x11-libs/qt-core:4
        x11-libs/qt-gui:4
"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_install() {
	insinto /usr/bin/
        dobin qtperf4 || die
}
