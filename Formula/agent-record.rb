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
      sha256 "6ff33fd5ea9cac0547200be26cfd66a95ef7d0c79ff61f6bb3b3519dca4d0663"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-record/releases/download/v0.1.0/agent-record-linux-x64.tar.gz"
      sha256 "71e45e2d02e60795797e0c79ad680652c83c9ec8d98eebd5c36f2d3dbb72926e"
    end
  end

  def install
    bin.install "agent-record"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp
  end
end
