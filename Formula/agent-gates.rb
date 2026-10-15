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
      sha256 "24600e59e66984f0f61fc5091299d7055a8cbdb3194d3faa598e74d2767d3a79"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-gates/releases/download/v0.1.0/agent-gates-linux-x64.tar.gz"
      sha256 "79ba03e29dfab02d52ae1043de91905aa546e19782ef70f4f32de128faeacf86"
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
