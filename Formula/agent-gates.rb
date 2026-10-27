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
      url "https://github.com/cniska/agent-gates/releases/download/v0.5.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "77ce2aa183ed469f2b6ccbe944f41d7bd40eb3762acc5dcdde564f6a3fb030ab"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.5.0/agent-gates-linux-x64.tar.gz"
      sha256 "361ee63a34e539ffe6d4f2491edb79a1aca64289016450454d8016fc17dc8215"
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
