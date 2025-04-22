# Open-Source Release Helpers

Utilities for changelog generation and release creation for open-source projects maintained by Veridise.

## Usage

This repository is primarily set up to be used via GitHub action workflow calls, with
the exception of the changelog creation, which must happen locally. The workflows provided
by this repository are as follows:

- [`changelog-validator`](.github/workflows/changelog-validator.yml): Runs `scripts/validateChangelogEntry.sh` for non-pre-release branches.
- [`prepare-release`](.github/workflows/prepare-release.yml): Creates a full changelog for the release.
- [`create-release-candidate`](.github/workflows/create-release-candidate.yml): Creates the version and tag for a new release.
- [`create-release-pr`](.github/workflows/create-release-pr.yml): Creates a pull request to create the release.
- [`release`](.github/workflows/release.yml): Finalizes the release and cleans up pre-release state.

For an example of usage, refer to the [LLZK project repository](https://github.com/Veridise/llzk-lib).

### Changelog Creation

The `scripts/createChangelogEntry.sh` script is used to create a new changelog that
accompanies a pull request. This script is a small utility to add a new changelog based
on a template (or an empty file) to the `changelogs/unreleased` directory of a repository.
The use of this script is optional, however it does set up the changelogs in a format
that is expected by the `changelog-validator` workflow and other release workflows.

Environment Variables:
- `PROJECT_PATH`: The root directory of the repository to create a new changelog in. Defaults to `.`
- `CHANGELOG_INPUT`: The directory to store unreleased changelogs in. Defaults to `changelogs/unreleased`, relative to `PROJECT_PATH`

Arguments:
- `--empty`: Creates an empty changelog instead of using the template.

#### Nix flake

If using this repository as a nix flake, the `createChangelogEntry.sh` script will
be installed as part of the derivation as `create-changelog`, but the package still
needs to be added to the PATH of the local development shell.
For example, see the [LLZK project flake](https://github.com/Veridise/llzk-lib/flake.nix).

#### Manual usage

If not using a nix flake, the `createChangelogEntry.sh` script can be copied to
your repository, along with `scripts/template.yaml`, or this repo can be added
as a submodule.

## Repository Layout

- `.github/workflows`: Workflows that can be dispatched by other repositories for changelog validation and release preparation/creation.
- `changelog_updater/`: Python utility to update the changelog.
- `mdx-validate/`: Validates the changelog MDX.
- `scripts/`: Contains the primary scripts used by the workflow. See [the usage docs](scripts/README.md) for manual usage examples.
