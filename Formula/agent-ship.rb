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
      url "https://github.com/cniska/agent-ship/releases/download/v0.3.0/agent-ship-darwin-arm64.tar.gz"
      sha256 "1b55f41b33188885adb1227b329d16df1b01b3b4ff59b4a79a5e88fce7f79005"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/agent-ship/releases/download/v0.3.0/agent-ship-linux-x64.tar.gz"
      sha256 "b39de1773c1afe7a5fdf3787c2175fc44987429fa0c7dd6e8aee2fd97aa219a3"
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
