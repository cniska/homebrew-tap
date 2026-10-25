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
      url "https://github.com/cniska/agent-gates/releases/download/v0.4.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "eb5d50f574477d73e76fbe05a8c6cd97053939224c3a9e2388d90734f19a88d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.4.0/agent-gates-linux-x64.tar.gz"
      sha256 "78628a5eb2ee44401ec4f1eed8b9f28f7571f7738b79a9a56f2193c35589a284"
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
