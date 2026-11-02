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
      url "https://github.com/cniska/agent-worktree/releases/download/v0.3.0/agent-worktree-darwin-arm64.tar.gz"
      sha256 "c5db3d38e763e407831383a0f6649052c7b230ee48a3b6fab5a0451b230422bc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-worktree/releases/download/v0.3.0/agent-worktree-linux-x64.tar.gz"
      sha256 "9001cbfee7f375b2c8c3c6a7a987dc53bf4fbfbf9cfc1f8ac1f1a31d743ec5d1"
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
      worktree = assert_match(/^  path: (.+)$/, shell_output("#{bin}/agent-worktree create made-up-task"))[1]
      assert_path_exists worktree
      system bin/"agent-worktree", "remove", "made-up-task"
      refute_path_exists worktree
    end
  end
end
