cask "bookside" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.0"
  sha256 arm:   "aa0b0f37c827acb831289107934d6e665d76534ff23601d8b3111281955fa3a9",
         intel: "9674b28a19b3c26dbdc50c28392e634912ce98b58613b07f33507c7e75e92466"

  url "https://github.com/NomaDamas/bookside/releases/download/v#{version}/Bookside-#{version}-macos-#{arch}.dmg"
  name "Bookside"
  desc "Native PDF reader with per-book notes, local OCR, and read-only MCP access"
  homepage "https://github.com/NomaDamas/bookside"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
    # Upstream marks numeric preview releases with GitHub's prerelease flag.
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"]

        release["tag_name"]&.[](regex, 1)
      end
    end
  end

  depends_on macos: :sonoma

  app "Bookside.app"
  binary "#{appdir}/Bookside.app/Contents/MacOS/bookside-cli"

  caveats <<~EOS
    Bookside 0.3.0 is an ad-hoc signed developer preview, not notarized by Apple.
    macOS may require first-launch approval in System Settings > Privacy & Security.
    Installation guidance: https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md
    OCR tools are optional and installed separately.
  EOS
end
