class SummarizeText < Formula
  desc "AI-powered text summarization tool for the command line"
  homepage "https://github.com/tigger-developer/summarize-text"
  url "https://github.com/tigger-developer/summarize-text/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "388324d52cc4842e093c4d4ad3b7618650cd3912edf713e48f6db11d6d8f4e2e"
  license "MIT"

  depends_on "bash"
  depends_on "jq"
  depends_on "curl"
  depends_on "html2text" => :recommended

  def install
    # Install main executable
    bin.install "summarize-text"

    # Install library
    (share/"summarize-text").install "summarize-text-lib.sh"

    # Install config example
    (share/"summarize-text").install "config.example" if File.exist?("config.example")

    # Update the script to use the correct library path
    inreplace bin/"summarize-text",
      'source "$(dirname "$0")/summarize-text-lib.sh"',
      "source \"#{share}/summarize-text/summarize-text-lib.sh\""
  end

  def caveats
    <<~EOS
      To configure summarize-text, create the config:
        mkdir -p ~/.config/summarize-text
        cat > ~/.config/summarize-text/config << EOF
        export OPENAI_API_KEY="your-key-here"
        # or export CLAUDE_API_KEY="your-key-here"
        # or use Ollama locally
        EOF

      You'll need at least one of:
        - OpenAI API key
        - Claude API key
        - Ollama running locally (brew install ollama)
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/summarize-text --help 2>&1")
  end
end
