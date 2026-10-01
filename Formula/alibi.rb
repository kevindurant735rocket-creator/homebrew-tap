class Alibi < Formula
  desc "Check what an AI coding agent wrote about its own work against what it did"
  homepage "https://github.com/kevindurant735rocket-creator/alibi"
  # Pinned to the release, not to "main": Homebrew installs a version, and a
  # formula pointing at a moving branch makes an upgrade impossible to reason
  # about. Bump the tag with each release.
  url "https://github.com/kevindurant735rocket-creator/alibi/archive/refs/tags/v0.3.0.tar.gz"
  version "0.3.0"
  license "MIT"
  head "https://github.com/kevindurant735rocket-creator/alibi.git", branch: "main"

  depends_on "python@3.9"

  def install
    libexec.install Dir["alibi"]
    (bin/"alibi").write <<~SH
      #!/usr/bin/env bash
      exec python3 -c 'import sys; sys.path.insert(0, "#{libexec}"); from alibi.cli import main; raise SystemExit(main())' "$@"
    SH
  end

  test do
    assert_match "alibi", shell_output("#{bin}/alibi --version")
  end
end
