# Bookside Homebrew tap

Install [Bookside](https://github.com/NomaDamas/bookside), a native macOS PDF reader
with per-book notes, local OCR, and read-only MCP access.

```sh
brew install --cask nomadamas/bookside/bookside
```

Homebrew selects the Apple Silicon or Intel DMG and verifies its SHA-256 checksum.
The cask installs `Bookside.app` and links the bundled `bookside-cli` into your
Homebrew `bin` directory. Bookside requires macOS 14 or later and a Homebrew version
that supports your macOS.

**The current version is an ad-hoc signed developer preview, not notarized by Apple.**
Homebrew installation preserves macOS quarantine. See the
[first-launch guide](https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md#install-the-developer-preview)
if macOS blocks opening it. OCR engines are optional, separate installations.

## Coming from Bookshelf

Bookside was called Bookshelf until 0.2.0. This tap was `nomadamas/bookshelf`, and
its `bookshelf` cask is now `bookside`. If you installed the `bookshelf` cask, quit
Bookshelf and run:

```sh
brew update
brew upgrade --cask bookshelf
```

Homebrew follows the rename: it removes `Bookshelf.app` and the `bookshelf-cli`
link, then installs `Bookside.app` and `bookside-cli`. Bookside reads your existing
library at `~/Library/Application Support/Bookshelf`; nothing is moved or deleted.
The old tap name keeps working, so you do not need to re-tap.

## Update and remove

Quit Bookside before updating:

```sh
brew update
brew upgrade --cask nomadamas/bookside/bookside
```

To remove the Homebrew installation:

```sh
brew uninstall --cask nomadamas/bookside/bookside
```

The cask removes its app and CLI link. It does not remove PDFs or the library at
`~/Library/Application Support/Bookshelf` (or `Bookside` on a new installation).
There is no `zap` cleanup that deletes notes or reading history.

If you already installed the app manually, quit it and check the installation
location before switching. Homebrew refuses to overwrite a different existing
app. Keep your old copy until the new installation works; see the
[installation guide](https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md).

## Maintain the cask

[`Casks/bookside.rb`](Casks/bookside.rb) is the distribution record for this tap.
It points to immutable assets in
[Bookside Releases](https://github.com/NomaDamas/bookside/releases).
Livecheck follows published numeric version tags, including developer previews.
It reports available versions; a reviewed cask update makes them installable here.

After publishing a new upstream version:

1. Create a branch in this tap. Update the cask's version and both architecture
   checksums from the published `.dmg.sha256` files and JSON manifests.
2. For an intentionally supported preview, update the exact version in
   [`github_prerelease_allowlist.json`](audit_exceptions/github_prerelease_allowlist.json).
   The current exception covers only `0.2.0`; it does not allow every future preview
   or skip draft, download, checksum, or installation checks. Remove the entry when
   the tap moves to a non-prerelease version.
3. Keep the preview/signing caveat accurate. Remove the signing warning only after
   the assets are actually Developer ID signed and notarized.
4. Run the checks below, open a pull request, and merge after both CI jobs pass.

Never overwrite an existing release asset to change what an already-published
checksum installs. Keep [`cask_renames.json`](cask_renames.json): it is how
existing `bookshelf` installations find this cask.

## Validate changes

The macOS CI workflow checks the cask on Apple Silicon and Intel: style, online
audit, installation into a temporary app directory, bundled CLI/version and
signature checks, and removal of the installed app and CLI link.

For a local maintainer checkout:

```sh
brew style --cask nomadamas/bookside/bookside
brew audit --cask --online nomadamas/bookside/bookside
brew fetch --cask --arch=all nomadamas/bookside/bookside
brew livecheck --cask nomadamas/bookside/bookside
```

Newer Homebrew versions require trust before loading a third-party cask for audit.
Use `brew trust --cask nomadamas/bookside/bookside` to trust this cask specifically.
The fully qualified install command above establishes that same scoped trust.

Report app problems in [Bookside issues](https://github.com/NomaDamas/bookside/issues)
and packaging problems in [this tap's issues](https://github.com/NomaDamas/homebrew-bookside/issues).
The tap is maintained by NomaDamas and is separate from Homebrew's official cask repository.

## License

[MIT](LICENSE), matching the Bookside project.
