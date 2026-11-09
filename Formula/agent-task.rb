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
      url "https://github.com/cniska/agent-task/releases/download/v0.5.0/agent-task-darwin-arm64.tar.gz"
      sha256 "7ad200d07a81e7574d4a3c88f9cb56f123e14f128f3f5bdf0522cd0b1c7bcb10"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-task/releases/download/v0.5.0/agent-task-linux-x64.tar.gz"
      sha256 "ae9d1613a67783c28bcfadc208b875acb52accac5ac77d7bbe261659a3ffb4a3"
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
