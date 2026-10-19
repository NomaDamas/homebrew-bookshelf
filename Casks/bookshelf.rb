cask "bookshelf" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.0"
  sha256 arm:   "5eb66b44ad16cdb8678cec9dd59ec1e7d13052671b5689cc4cd21aadc5382163",
         intel: "8d89adb33088c03c92b1f9bf8781aa341c83f3b6f18aa34ced73a46e34c10889"

  url "https://github.com/NomaDamas/bookside/releases/download/v#{version}/Bookshelf-#{version}-macos-#{arch}.dmg"
  name "Bookshelf"
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

  app "Bookshelf.app"
  binary "#{appdir}/Bookshelf.app/Contents/MacOS/bookshelf-cli"

  caveats <<~EOS
    Bookshelf 0.1.0 is an ad-hoc signed developer preview, not notarized by Apple.
    macOS may require first-launch approval in System Settings > Privacy & Security.
    Installation guidance: https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md
    OCR tools are optional and installed separately.
  EOS
end
