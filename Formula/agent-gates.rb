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
      url "https://github.com/cniska/agent-gates/releases/download/v0.7.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "00727012f10bae780e6ce469efeaae0648713ee55339c0167ccd2b967d9da76e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.7.0/agent-gates-linux-x64.tar.gz"
      sha256 "1207bc0c05112e7bbf8bc508110acdfcfd2054ede87a351ebbad48f0f6106d20"
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
