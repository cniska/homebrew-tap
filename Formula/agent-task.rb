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
      url "https://github.com/cniska/agent-task/releases/download/v0.2.1/agent-task-darwin-arm64.tar.gz"
      sha256 "66d16e8acf2096a565793ce02a483bb18d8eed08f302edec7872856e78f34bf2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-task/releases/download/v0.2.1/agent-task-linux-x64.tar.gz"
      sha256 "5fa01301cd5a1af81ae6528527ddb93458c0a01c81676a166ee1b985fb163957"
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
      assert_match(/^    made-up-task,running,/, shell_output("#{bin}/agent-task list"))
      assert_match(/^ok: true$/, shell_output("#{bin}/agent-task done made-up-task"))
      assert_match(/^    fail: 0$/, shell_output("#{bin}/agent-task doctor"))
    end
  end
end
