EAPI="4"
inherit eutils flag-o-matic multilib pax-utils

DESCRIPTION="Crack language compiler, virtual machine, library"
HOMEPAGE="http://www.crack-lang.org/"
SRC_URI="https://crack-language.googlecode.com/files/${PN}-${PV}.tar.gz"
KEYWORDS="~amd64"
SLOT="0"
LICENSE="MPL-2.0"

RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-libs/libffi
	dev-libs/libpcre
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	media-libs/libsdl
	=sys-devel/llvm-3.1*
	sys-libs/zlib
	virtual/opengl
	x11-libs/gtk+:2
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXrender
	x11-libs/libxcb
	x11-libs/pixman
	"
DEPEND="
	${RDEPEND}
	sys-devel/gcc
	virtual/pkgconfig
	"

src_prepare() {
	epatch "${FILESDIR}/crack-nopie.patch"
}

src_compile() {
	emake CXXFLAGS="-g -O3 -march=native -fomit-frame-pointer -funroll-loops --param max-unrolled-insns=64 -fno-PIE -fPIC"
	pax-mark m .libs/crack
}

src_install() {
	emake -j1 DESTDIR="${D}" install
}
