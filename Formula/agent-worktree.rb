class AgentWorktree < Formula
  desc "Task worktrees so coding agents working in parallel never share a checkout"
  homepage "https://github.com/cniska/agent-worktree"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/agent-worktree/releases/download/v0.1.0/agent-worktree-darwin-arm64.tar.gz"
      sha256 "0ec782a9c8deae34d1539c004d63f379eb8bec7e6803bef496c8ec56b6e3641e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-worktree/releases/download/v0.1.0/agent-worktree-linux-x64.tar.gz"
      sha256 "f2674b775a23136f455deb127a6ef7c898564c996b542fabcb9d88375857c2e6"
    end
  end

  def install
    bin.install "agent-worktree"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-worktree --version").chomp

    ENV["XDG_DATA_HOME"] = (testpath/"data").to_s
    system "git", "init", "-q", "-b", "main", "project"
    cd "project" do
      system "git", "-c", "user.name=Test", "-c", "user.email=test@example.com",
             "commit", "-q", "--allow-empty", "-m", "made-up commit"
      worktree = shell_output("#{bin}/agent-worktree create made-up-task").chomp
      assert_path_exists worktree
      system bin/"agent-worktree", "remove", "made-up-task"
      refute_path_exists worktree
    end
  end
end
