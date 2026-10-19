# Bookshelf Homebrew tap

Install [Bookshelf](https://github.com/NomaDamas/bookside), a native macOS PDF reader
with per-book notes, local OCR, and read-only MCP access.

The project is now named Bookside. This cask still installs the Bookshelf 0.1.0
developer preview; the `bookside` cask arrives with the first Bookside release.

```sh
brew install --cask nomadamas/bookshelf/bookshelf
```

Homebrew selects the Apple Silicon or Intel DMG and verifies its SHA-256 checksum.
The cask installs `Bookshelf.app` and links the bundled `bookshelf-cli` into your
Homebrew `bin` directory. Bookshelf requires macOS 14 or later and a Homebrew version
that supports your macOS.

**The current version is an ad-hoc signed developer preview, not notarized by Apple.**
Homebrew installation preserves macOS quarantine. See the
[first-launch guide](https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md#install-the-developer-preview)
if macOS blocks opening it. OCR engines are optional, separate installations.

## Update and remove

Quit Bookshelf before updating:

```sh
brew update
brew upgrade --cask nomadamas/bookshelf/bookshelf
```

To remove the Homebrew installation:

```sh
brew uninstall --cask nomadamas/bookshelf/bookshelf
```

The cask removes its app and CLI link. It does not remove PDFs or the library at
`~/Library/Application Support/Bookshelf`. There is no `zap` cleanup that deletes
notes or reading history.

If you already installed the app manually, quit it and check the installation
location before switching. Homebrew refuses to overwrite a different existing
app. Keep your old copy until the new installation works; see the
[installation guide](https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md).

## Maintain the cask

[`Casks/bookshelf.rb`](Casks/bookshelf.rb) is the distribution record for this tap.
It points to immutable assets in
[Bookshelf Releases](https://github.com/NomaDamas/bookside/releases).
Livecheck follows published numeric version tags, including developer previews.
It reports available versions; a reviewed cask update makes them installable here.

After publishing a new upstream version:

1. Create a branch in this tap. Update the cask's version and both architecture
   checksums from the published `.dmg.sha256` files and JSON manifests.
2. For an intentionally supported preview, update the exact version in
   [`github_prerelease_allowlist.json`](audit_exceptions/github_prerelease_allowlist.json).
   The current exception covers only `0.1.0`; it does not allow every future preview
   or skip draft, download, checksum, or installation checks. Remove the entry when
   the tap moves to a non-prerelease version.
3. Keep the preview/signing caveat accurate. Remove the signing warning only after
   the assets are actually Developer ID signed and notarized.
4. Run the checks below, open a pull request, and merge after both CI jobs pass.

Never overwrite an existing release asset to change what an already-published
checksum installs.

## Validate changes

The macOS CI workflow checks the cask on Apple Silicon and Intel: style, online
audit, installation into a temporary app directory, bundled CLI/version and
signature checks, and removal of the installed app and CLI link.

For a local maintainer checkout:

```sh
brew style --cask nomadamas/bookshelf/bookshelf
brew audit --cask --online nomadamas/bookshelf/bookshelf
brew fetch --cask --arch=all nomadamas/bookshelf/bookshelf
brew livecheck --cask nomadamas/bookshelf/bookshelf
```

Newer Homebrew versions require trust before loading a third-party cask for audit.
Use `brew trust --cask nomadamas/bookshelf/bookshelf` to trust this cask specifically.
The fully qualified install command above establishes that same scoped trust.

Report app problems in [Bookshelf issues](https://github.com/NomaDamas/bookside/issues)
and packaging problems in [this tap's issues](https://github.com/NomaDamas/homebrew-bookshelf/issues).
The tap is maintained by NomaDamas and is separate from Homebrew's official cask repository.

## License

[MIT](LICENSE), matching the Bookshelf project.
