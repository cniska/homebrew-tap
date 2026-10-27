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
      url "https://github.com/cniska/agent-worktree/releases/download/v0.2.0/agent-worktree-darwin-arm64.tar.gz"
      sha256 "de08fe4291598055651c1c663f858c6afb8b56c3d8fda4e210840ef921f7f964"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-worktree/releases/download/v0.2.0/agent-worktree-linux-x64.tar.gz"
      sha256 "d0ed3426f464a5255685359fd371cc788002fe484d87e85d6383795a365e3dc0"
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
