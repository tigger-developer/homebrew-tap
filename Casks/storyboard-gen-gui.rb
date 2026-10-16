# ABOUTME: Homebrew cask for storyboard-gen GUI application.
# ABOUTME: Installs the PySide6 GUI as a standalone macOS .app bundle.

cask "storyboard-gen-gui" do
  version "0.72.0"
  sha256 "14d61a0968611c689a61522dab95e736321b9a17a08e37aa036c580c39cd3970"

  url "https://github.com/tigger-developer/storyboard-gen/releases/download/v#{version}/storyboard-gen-gui-#{version}.dmg"
  name "Storyboard Gen"
  desc "Generate video stills and clips from YAML storyboards using AI"
  homepage "https://github.com/tigger-developer/storyboard-gen"

  depends_on macos: ">= :monterey"

  app "Storyboard Gen.app"

  zap trash: [
    "~/Library/Preferences/com.tigger04.storyboard-gen.plist",
  ]

  caveats <<~EOS
    Storyboard Gen GUI requires ffmpeg to be installed:
      brew install ffmpeg

    At least one AI provider is required. Configure credentials in a .env
    file in your project directory (Google, FAL.ai, or Replicate).
    See: https://github.com/tigger-developer/storyboard-gen#quickstart

    The CLI tool is available separately:
      brew install tigger-developer/tap/storyboard-gen
  EOS
end
