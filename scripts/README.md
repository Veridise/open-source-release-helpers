# Scripts

## Create changelogEntry file
```
./release_helpers/scripts/createChangelogEntry.sh
```
Now edit `changelogs/unreleased/<branch_name>.yaml` according to your changes in this branch
> [!NOTE]
> Always run the script from the root folder of your project.

To create an empty file provide the `--empty` option
```sh
./release_helpers/scripts/createChangelogEntry.sh --empty
```

## Validate changelogEntry file of current branch
```sh
./release_helpers/scripts/validateChangelogEntry.sh
```
> [!NOTE]
> Always run the script from the root folder of your project.

## Create pre-release files
```sh
./release_helpers/scripts/createPreReleaseFiles.sh v0.0.1
```
> [!NOTE]
> Always run the script from the root folder of your project.

## Create final CHANGELOG.md and remove pre-release files
```sh
./release_helpers/scripts/updateChangelog.sh v0.0.1
```

> [!NOTE]
> Always run the script from the root folder of your project.
