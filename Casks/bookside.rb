cask "bookside" do
  arch arm: "arm64", intel: "x86_64"

  version "0.2.0"
  sha256 arm:   "3813ebbd2e7c4e393496cec5c4096254bb189453439f7612add25dc6d6c20fec",
         intel: "445609a292a9c7b8d2df60c809f54b16b213ba28f95ae3966dde2bd9cdac0bf4"

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
    Bookside 0.2.0 is an ad-hoc signed developer preview, not notarized by Apple.
    macOS may require first-launch approval in System Settings > Privacy & Security.
    Installation guidance: https://github.com/NomaDamas/bookside/blob/main/docs/01-getting-started.md
    OCR tools are optional and installed separately.
  EOS
end
