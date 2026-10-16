class Pix < Formula
  desc "Generate images from text prompts via the FAL API"
  homepage "https://github.com/tigger-developer/pix"
  disable! date: "2026-10-16", because: "depends on a private source repository"
  url "https://github.com/tigger-developer/pix/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w -X main.version=0.7.0", "-o", bin/"pix", "."
  end

  test do
    assert_match "pix 0.7.0", shell_output("#{bin}/pix --version")
    assert_match "Usage: pix", shell_output("#{bin}/pix --help 2>&1")
  end
end
