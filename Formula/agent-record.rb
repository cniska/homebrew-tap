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
      url "https://github.com/cniska/agent-record/releases/download/v0.4.0/agent-record-darwin-arm64.tar.gz"
      sha256 "6a62b530881f9bb9d3329f8a1f266d3b2fa2f42f7632efeb6eb204776184e2b8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-record/releases/download/v0.4.0/agent-record-linux-x64.tar.gz"
      sha256 "dda93033108f6ed44e6ffe3052d8958b85b8b9928552c31712272e1f13d99775"
    end
  end

  def install
    bin.install "agent-record"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp
  end
end
