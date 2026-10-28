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
      url "https://github.com/cniska/agent-gates/releases/download/v0.8.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "e0cbb888bdd647cd7f5bc57e8128be8536473caeded7e7c872765c3d3e1cbf7b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.8.0/agent-gates-linux-x64.tar.gz"
      sha256 "542d1765be2348ecec0af7d0156b1a37d9846e1c6da0f57919213a8e75944aca"
    end
  end

  def install
    bin.install "agent-gates"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-gates --version").chomp

    system "git", "init", "-q"
    (testpath/"notes.txt").write "made-up content\n"
    assert_match(/^ok: true$/, shell_output("#{bin}/agent-gates install commit-subject"))
    assert_match(/^    fail: 0$/, shell_output("#{bin}/agent-gates doctor"))
  end
end
