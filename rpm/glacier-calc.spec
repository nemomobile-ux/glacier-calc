Name:       glacier-calc

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    Nemo calculator
Version:    0.3.0
Release:    1
Group:      Applications/System
License:    LGPL v2.1
URL:        http://github.com/nemomobile-ux/glacier-calc
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt-components-qt5
Requires:   qt5-qtquickcontrols
Requires:   qt5-qtquickcontrols-nemo
Requires:   libglacierapp

BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  desktop-file-utils
BuildRequires:  pkgconfig(glacierapp)

%description
Calculator application written using QML

%prep
%setup -q -n %{name}-%{version}

%build
%qtc_qmake5
%qtc_make %{?_smp_mflags}

%install
rm -rf %{buildroot}
%qmake5_install

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}/glacier-calc
%{_datadir}/applications/glacier-calc.desktop
%{_datadir}/glacier-calc/*
