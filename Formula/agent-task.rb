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
      url "https://github.com/cniska/agent-task/releases/download/v0.4.0/agent-task-darwin-arm64.tar.gz"
      sha256 "bd38be1d88720b18f9ccba4d1baf6758dc4f5050e2e0491aef0f95b6b1d3b4ac"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-task/releases/download/v0.4.0/agent-task-linux-x64.tar.gz"
      sha256 "1eade98c97bbd42f5a1f4e62cbcaf2f53fc13f9160c8abfb2dc018f48f1233b9"
    end
  end

  def install
    bin.install "agent-task"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-task --version").chomp

    ENV["XDG_DATA_HOME"] = (testpath/"data").to_s
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
