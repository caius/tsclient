# Changelog

All notable changes to this project will be documented below. The format is based on [Keep a Changelog][keep-changelog], and this project adheres to [Semantic Versioning][semver].

[keep-changelog]: https://keepachangelog.com/en/1.0.0/
[semver]: https://semver.org/spec/v2.0.0.html

<!--
  - **Added** for new features.
  - **Changed** for changes in existing functionality.
  - **Deprecated** for soon-to-be removed features.
  - **Removed** for now removed features.
  - **Fixed** for any bug fixes.
  - **Security** in case of vulnerabilities.
 -->

## [Unreleased]

- Added: `Tsclient::ApiFinder` handles finding the api in known places
- Changed: Switch to Zeitwerk for loading internally

## [0.1.1] - 2022-10-22

- Changed: pinned dependencies to major versions
- Fixed: Changelog link in gemspec

## [0.1.0] - 2022-10-22

- Added: Client can query whois a remote address
- Added: Client can query current tailscale IPs
- Added: `Tsclient.default_client` works on macOS

## [0.0.1] - 2022-10-20

- Added: Initial release
