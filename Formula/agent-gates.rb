class AgentGates < Formula
  desc "Git hooks and GitHub workflows that gate coding agents' commits"
  homepage "https://github.com/cniska/agent-gates"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/agent-gates/releases/download/v0.2.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "ba9625ebe455f9f1cddab1ce5a4d89c177600d879dc8898ed7d0b409f31e3c4d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.2.0/agent-gates-linux-x64.tar.gz"
      sha256 "441600df98debf5174b0b7d400ead3f0f6103d86334513b2de26c5824cf21b38"
    end
  end

  def install
    bin.install "agent-gates"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-gates --version").chomp

    system "git", "init", "-q"
    (testpath/"notes.txt").write "made-up content\n"
    assert_match '"ok":true', shell_output("#{bin}/agent-gates install commit-subject")
    assert_match '"failing":0', shell_output("#{bin}/agent-gates doctor")
  end
end
