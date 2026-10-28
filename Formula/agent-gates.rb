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
      url "https://github.com/cniska/agent-gates/releases/download/v0.9.0/agent-gates-darwin-arm64.tar.gz"
      sha256 "0f7605f046807804ca71dab7b98f3782f3a6710db981efe3c757721a44c004a9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.9.0/agent-gates-linux-x64.tar.gz"
      sha256 "588f41dff77219e3d1288e50210fa9483ffa372e4e40f91763b1723a681fe0b2"
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
