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

  resource "launcher" do
    url "https://github.com/cniska/agent-record/releases/download/v0.1.0/launcher.sh"
    sha256 "7d82b0f1b4e727001a815ebd98901122e95d3c1879fb521fe11105f090127be7"
  end

  def install
    libexec.install "agent-record"

    resource("launcher").stage do
      inreplace "launcher.sh" do |s|
        s.gsub! "__BASELINE_BIN__", "#{libexec}/agent-record"
        s.gsub! "__BASELINE_VERSION__", version.to_s
      end
      bin.install "launcher.sh" => "agent-record"
    end
  end

  test do
    ENV["AGENT_RECORD_SKIP_UPDATE"] = "1"
    assert_equal version.to_s, shell_output("#{bin}/agent-record --version").chomp

    ENV["XDG_DATA_HOME"] = testpath/"data"
    staged = testpath/"data/agent-record/bin/99.0.0"
    staged.mkpath
    (staged/"agent-record").write "#!/bin/sh\necho staged\n"
    chmod 0755, staged/"agent-record"
    assert_equal "staged", shell_output(bin/"agent-record").chomp
  end
end
