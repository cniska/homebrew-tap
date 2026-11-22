class AgentTask < Formula
  desc "Coding agents' parallel tasks, each with its repo and the brief it started from"
  homepage "https://github.com/cniska/agent-task"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/agent-task/releases/download/v0.6.0/agent-task-darwin-arm64.tar.gz"
      sha256 "9bb5fed4a79b64a8fc6a8a3cd1b1f8f5b41f926a56e8c759dbd3fe34356644b3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-task/releases/download/v0.6.0/agent-task-linux-x64.tar.gz"
      sha256 "3c345b4830679927e0735f19a4d417677b740d6f7f8f72eb84ac1a895eeb8f9c"
    end
  end

  def install
    bin.install "agent-task"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-task --version").chomp

    ENV["XDG_DATA_HOME"] = (testpath/"data").to_s
    (testpath/"data/agent-task").mkpath
    (testpath/"data/agent-task/limits.json").write '{"maxLoadPerCore": 1000000, "minAvailableMemory": 0}'
    system "git", "init", "-q", "repo"
    cd "repo" do
      (testpath/"repo/brief.md").write "# Made-up brief\n"
      assert_match(/^ok: true$/, shell_output("#{bin}/agent-task start made-up-task --repo . --brief brief.md"))
      assert_match(/^    made-up-task,(null,)?running,/, shell_output("#{bin}/agent-task list"))
      assert_match(/^ok: true$/, shell_output("#{bin}/agent-task done made-up-task"))
      assert_match(/^    fail: 0$/, shell_output("#{bin}/agent-task doctor"))
    end
  end
end
