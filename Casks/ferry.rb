# Ferry's Homebrew cask, for the cloudwalkerlabs/homebrew-tap tap:
#
#   brew install cloudwalkerlabs/tap/ferry
#
# The Build workflow fills in the @...@ fields (packaging/macos/cask.sh) and
# pushes the result to the tap as Casks/ferry.rb with each release.
cask "ferry" do
  version "1.16.0"
  sha256 "aa99b5fb23b26ca194b6e2d6824c50c38a97fcf85b9df8e16428f197f795817e"

  url "https://github.com/cloudwalkerlabs/ferryapp/releases/download/v1.16.0/ferry-1.16.0-macos-universal.dmg"
  name "Ferry"
  desc "KDE Connect client: share files and the clipboard with your phone"
  homepage "https://cloudwalkerlabs.github.io/ferryapp/"

  depends_on macos: :monterey

  app "Ferry.app"
  binary "#{appdir}/Ferry.app/Contents/MacOS/ferry-cli"

  # The app is signed with a self-signed certificate, not notarized, so
  # Gatekeeper would refuse the copy Homebrew marked as downloaded.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Ferry.app"]
  end

  uninstall quit: "dev.fanchao.Ferry"

  zap trash: [
    "~/Library/Application Support/dev.fanchao.Ferry",
    "~/Library/Application Support/Ferry",
    "~/Library/LaunchAgents/dev.fanchao.Ferry*.plist",
  ]
end
