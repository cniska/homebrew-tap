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
      url "https://github.com/cniska/agent-gates/releases/download/v0.1.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "f5f5f55b9a07e172fb1ff03184cfb0a702e99ec8fbf52e00df8dc3f413f4229a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.1.0/agent-gates-linux-x64.tar.gz"
      sha256 "97ac8a9d7768400575506a015a0a53248adc111666ed205a45e0ba0bf20fe7c8"
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
