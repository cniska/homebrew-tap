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
      url "https://github.com/cniska/agent-gates/releases/download/v0.3.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "072b0a0486290e8487e9b342aedc5bbdf7f72c077654b9c5c1c4854364863544"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.3.0/agent-gates-linux-x64.tar.gz"
      sha256 "5b687985392da0a245b0e24f58bb5980ab55edf080c850f24a052a2b739c1042"
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
