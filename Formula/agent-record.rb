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
      url "https://github.com/cniska/agent-record/releases/download/v0.3.0/agent-record-darwin-arm64.tar.gz"
      sha256 "2f31418f2dad111f668a86bf53d8a2261c9713f216ecfcb6fb9c0d96af2f6e74"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-record/releases/download/v0.3.0/agent-record-linux-x64.tar.gz"
      sha256 "f25183ac2179687fc62f00d605f4a0a882c1966622f0e4006662dc45c1222a3e"
    end
  end

  def install
    bin.install "agent-record"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp
  end
end
