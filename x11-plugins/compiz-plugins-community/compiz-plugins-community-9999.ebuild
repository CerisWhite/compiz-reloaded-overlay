# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils git-r3

DESCRIPTION="Compiz Window Manager: Community Plugins"
HOMEPAGE="http://futuramerlin.com/"
EGIT_REPO_URI="https://github.com/ethus3h/${PN}.git"

LICENSE="GPL-2+ BSD"
SLOT="0"

RDEPEND="
	app-misc/cwiid
	media-libs/opencv
	gnome-base/librsvg
	virtual/jpeg:0
	>=x11-libs/compiz-bcop-${PV}
	>=x11-plugins/compiz-plugins-experimental-${PV}
	>=x11-wm/compiz-${PV}
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=sys-devel/gettext-0.15
	virtual/pkgconfig
	x11-libs/cairo
"

src_prepare(){
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-fast-install \
		--disable-static
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
