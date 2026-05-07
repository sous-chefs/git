# Limitations

## Package Availability

Git does not publish first-party Linux package repositories. Linux package installs use the
package supplied by the operating system repository. The upstream Git installation guide lists
native package-manager installs for Debian/Ubuntu, Fedora, openSUSE, FreeBSD, Solaris/OpenIndiana,
RHEL-family distributions, and other platforms.

### APT (Debian/Ubuntu)

* Debian 12 and 13: `git` is available from the distribution APT repositories.
* Ubuntu 22.04, 24.04, and 26.04: `git` is available from the distribution APT repositories.
* Ubuntu 20.04 is only in Extended Security Maintenance as of May 7, 2026 and is not part of the
  supported Kitchen matrix for this cookbook.

### DNF/YUM (RHEL family)

* AlmaLinux, CentOS Stream, Fedora, Oracle Linux, Red Hat, and Rocky Linux: `git` is available from
  distribution repositories.
* RHEL-family repositories may carry older Git releases. Upstream Git recommends building from
  source or using a third-party repository when a newer version is required.

### Zypper (SUSE)

* openSUSE Leap: `git` is available from the distribution Zypper repositories.

### Windows

* Windows installs use Git for Windows release installers from GitHub.
* The Git for Windows download page currently publishes x64 and ARM64 setup installers. Historical
  32-bit installer support should be treated as legacy and version-specific.

### macOS

* macOS package installs use the platform package provider. Homebrew must already be installed when
  using the Homebrew-backed package provider.

## Architecture Limitations

* Linux package architecture support is inherited from each operating system repository.
* Source installs require a supported compiler toolchain for the target architecture.
* The default source build tracks Git 2.54.0 from the official kernel.org tarball. Older Git
  releases such as 2.17.1 do not build against current libcurl headers on Debian 13.
* Git for Windows installer architectures are controlled by the upstream Git for Windows release.

## Source/Compiled Installation

### Build Dependencies

| Platform Family | Packages |
|-----------------|----------|
| Debian | `build-essential`, `libcurl4-gnutls-dev`, `libexpat1-dev`, `gettext`, `libz-dev`, `libssl-dev`, optional `libpcre3-dev` |
| RHEL/Amazon/Fedora | `build-essential`, `tar`, `expat-devel`, `gettext-devel`, `libcurl-devel`, `openssl-devel`, `perl-ExtUtils-MakeMaker`, `zlib-devel`, optional `pcre-devel` |
| SUSE | `build-essential`, `tar`, `libcurl-devel`, `libexpat-devel`, `gettext-tools`, `zlib-devel`, `libopenssl-devel`, optional `libpcre2-devel` |

## Known Issues

* This cookbook no longer ships a `git::server` recipe. The historical xinetd Git daemon path was
  removed before this migration and is not restored by the custom-resource API.
* Source install is Linux-only in this cookbook and is limited to Debian, RHEL, Fedora, Amazon, and
  SUSE platform families.
* Documentation references: upstream Git install guide
  (<https://git-scm.com/install/linux.html>), Git for Windows download page
  (<https://git-scm.com/install/windows.html>), and Git source mirror INSTALL guidance
  (<https://github.com/git/git>).
