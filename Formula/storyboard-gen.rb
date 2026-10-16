class StoryboardGen < Formula
  desc "Generate video stills and clips from a YAML storyboard using AI providers"
  homepage "https://github.com/tigger-developer/storyboard-gen"
  url "https://github.com/tigger-developer/storyboard-gen/archive/refs/tags/v0.72.0.tar.gz"
  sha256 "13defe9db324e724d8cb117f3f29f6ae711283944d5cbcdfa6fc7a6045ba63ad"
  license "MIT"

  depends_on "python@3.12"
  depends_on "ffmpeg"

  def install
    # Create virtualenv and install package with all Python dependencies
    venv = libexec/"venv"
    system "python3.12", "-m", "venv", venv
    venv_pip = venv/"bin/pip"
    system venv_pip, "install", "--upgrade", "pip"
    system venv_pip, "install", "#{buildpath}[all]"

    # Create wrapper script
    (bin/"storyboard-gen").write <<~EOS
      #!/bin/bash
      exec "#{venv}/bin/storyboard-gen" "$@"
    EOS
  end

  def caveats
    <<~EOS
      storyboard-gen requires at least one AI provider. Configure credentials
      in a .env file in your project directory:

      Google (Vertex AI — stills + clips):
        brew install google-cloud-sdk
        gcloud auth application-default login
        USE_VERTEX=true
        GOOGLE_CLOUD_PROJECT=your-project-id
        GOOGLE_CLOUD_LOCATION=us-central1

      FAL.ai (Flux, Kontext, Kling — stills + clips):
        FAL_KEY=your-fal-key

      Replicate (Flux — stills only):
        REPLICATE_API_TOKEN=your-replicate-token

      Then create a project.yaml and run:
        storyboard-gen validate
        storyboard-gen generate --all
        storyboard-gen assemble
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/storyboard-gen --version")
  end
end
