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
      url "https://github.com/cniska/agent-record/releases/download/v0.2.0/agent-record-darwin-arm64.tar.gz"
      sha256 "de8fa84a4bfb1e5efb361d17358f3dc138a707d296f8f7fe2721242a6194abf8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-record/releases/download/v0.2.0/agent-record-linux-x64.tar.gz"
      sha256 "b8bd36742ea4af3f3d86cb4cc76ecb2df5b883ee258610fe0d311904edc1945f"
    end
  end

  def install
    bin.install "agent-record"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp
  end
end
