Name:           ezmonitor
Version:        0.1.0
Release:        0
Summary:        KDE Plasma 6 applet to monitor solar panel data via APsystems EZ1
License:        GPL-3.0-or-later
URL:            https://www.opencode.net/agundur/ezmonitor
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  cmake
BuildRequires:  gcc-c++

BuildRequires: qt6-base-devel
BuildRequires: qt6-declarative-devel
BuildRequires: kf6-extra-cmake-modules
BuildRequires: qt6-tools-devel

Requires: plasma6-workspace

%global plasmoid_id de.agundur.ezmonitor

%description
EZMonitor is a Plasma 6 applet that queries the APsystems EZ1 inverter via local JSON API and displays current solar panel power and daily yield.

%prep
%setup -q

%build
%cmake package
%cmake_build

%install
%cmake_install


%files
%license LICENSE
%doc README.md
%{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/


# %dir %{_datadir}/plasma/plasmoids/de.agundur.ezmonitor
# %dir %{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/contents
# %dir %{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/contents/ui
# %{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/metadata.json
# %{_datadir}/plasma/plasmoids/de.agundur.ezmonitor/contents/ui/main.qml
