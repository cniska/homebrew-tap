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
      url "https://github.com/cniska/agent-task/releases/download/v0.1.0/agent-task-darwin-arm64.tar.gz"
      sha256 "bc8cf04a922d133e345697f15527de23a906ceeeb9b841d0e6dcacca57702e06"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-task/releases/download/v0.1.0/agent-task-linux-x64.tar.gz"
      sha256 "6d880e9c9f5ae155b151c2b670338c2f1f5277cb1bd8246be96a3165ed5a8d9a"
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
      assert_match '"ok":true', shell_output("#{bin}/agent-task start made-up-task --repo . --brief brief.md")
      assert_match '"name":"made-up-task"', shell_output("#{bin}/agent-task list")
      assert_match '"ok":true', shell_output("#{bin}/agent-task done made-up-task")
      assert_match '"failing":0', shell_output("#{bin}/agent-task doctor")
    end
  end
end
