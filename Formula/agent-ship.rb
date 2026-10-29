class AgentShip < Formula
  desc "Cut a release, wait for its CI and confirm it reached every channel"
  homepage "https://github.com/cniska/agent-ship"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/agent-ship/releases/download/v0.1.0/agent-ship-darwin-arm64.tar.gz"
      sha256 "9c4d02861831563b19b66cf216488bc3e3fdcfae71a95c3cddc5a636aed253fb"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-ship/releases/download/v0.1.0/agent-ship-linux-x64.tar.gz"
      sha256 "414de177050bfcca222b1a47728fbf2b5711d6f33410d27c2abff2aadeca98f4"
    end
  end

  def install
    bin.install "agent-ship"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-ship --version").chomp

    %w[AUTHOR COMMITTER].each do |role|
      ENV["GIT_#{role}_NAME"] = "Made Up"
      ENV["GIT_#{role}_EMAIL"] = "made-up@example.com"
    end
    system "git", "init", "-q", "--bare", "origin.git"
    system "git", "init", "-q", "-b", "main", "repo"
    cd "repo" do
      (testpath/"repo/ship.toml").write <<~TOML
        version = "package.json"
        tag = "v<version>"
        branch = "main"
        check = "true"
        signed = false

        [channels.npm]
        packages = ["made-up"]
        smoke = "true"
      TOML
      (testpath/"repo/package.json").write '{"name":"made-up","version":"1.2.3"}'
      system "git", "add", "."
      system "git", "commit", "-q", "-m", "feat: start"
      system "git", "remote", "add", "origin", "../origin.git"
      system "git", "push", "-q", "origin", "main"
      output = shell_output("#{bin}/agent-ship check")
      assert_match(/^ok: true$/, output)
      assert_match(/^  version: 1\.2\.3$/, output)
    end
  end
end
