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
      url "https://github.com/cniska/agent-gates/releases/download/v0.10.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "d31008c0bd584e76522b8b8b670261709bb5e404578211fe7219a054c8087948"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.10.0/agent-gates-linux-x64.tar.gz"
      sha256 "ca7b625da3401fa3fef5c9c811f6a6ada7eb059404bf4dbffa8e39be917c2270"
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
