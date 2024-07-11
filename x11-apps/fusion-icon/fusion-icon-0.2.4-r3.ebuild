# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{4,5,6,7,8,9,10,11,12} )

DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 gnome2-utils

DESCRIPTION="Fusion Icon (Compiz tray icon) for Compiz 0.8.x series"
HOMEPAGE="https://gitlab.com/compiz"
SRC_URI="https://github.com/compiz-reloaded/${PN}/releases/download/v${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 qt5"
REQUIRED_USE="?? ( gtk3 ) ?? ( qt5 ) || ( gtk3 qt5 )"

RDEPEND="${PYTHON_DEPS}
	>=dev-python/compizconfig-python-0.8.12[${PYTHON_SINGLE_USEDEP}]
	<dev-python/compizconfig-python-0.9
	$(python_gen_cond_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	x11-apps/xvinfo
	x11-apps/mesa-progs
	>=x11-wm/compiz-0.8
	<x11-wm/compiz-0.9
	gtk3? (
		dev-libs/libappindicator:3
	)
	qt5? (
		$(python_gen_cond_dep '
			dev-python/PyQt5[${PYTHON_USEDEP}]
		')
	)
"

DEPEND="${RDEPEND}"

src_configure() {
	DISTUTILS_ARGS=(
		build
		"--with-qt=5.0"
		"--with-gtk=3.0"
	)
}

src_install() {
	DISTUTILS_ARGS=(
		install
		--prefix=/usr
	)
	distutils-r1_python_install_all
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
