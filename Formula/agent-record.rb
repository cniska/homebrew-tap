class AgentRecord < Formula
  desc "Searchable record of every coding-agent session on this machine"
  homepage "https://github.com/cniska/agent-record"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/agent-record/releases/download/v0.1.0/agent-record-darwin-arm64.tar.gz"
      sha256 "1f968d1f9e6240cb6059b847e8e72475d5cb19b6a3870235893b33c2d9222d20"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-record/releases/download/v0.1.0/agent-record-linux-x64.tar.gz"
      sha256 "e9426dfdf123991db0fa7f321f252a0abd1a921a0fd7e8a08a142507f50948a0"
    end
  end

  def install
    bin.install "agent-record"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp
  end
end
