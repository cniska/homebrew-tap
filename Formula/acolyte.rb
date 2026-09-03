class Acolyte < Formula
  desc "Terminal-first AI coding agent with an inspectable runtime"
  homepage "https://acolyte.sh"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/acolyte/releases/download/v0.27.1/acolyte-darwin-arm64.tar.gz"
      sha256 "47ffb49d66aa94b83ae4e91233505bd08549fc0709add2c0443d6d565eb81f71"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/acolyte/releases/download/v0.27.1/acolyte-linux-x64.tar.gz"
      sha256 "72ab40ea0a3876ad3236052d73ff2c696650af79f8f83712aa61c380627b7d84"
    end
  end

  # The launcher execs the newest of this formula's binary and any build staged in the data
  # directory, so a self-update never writes into the Cellar and `brew upgrade` wins whenever
  # it is ahead.
  resource "launcher" do
    url "https://github.com/cniska/acolyte/releases/download/v0.27.1/launcher.sh"
    sha256 "3ba729636156792df70c47e58c4ec4f667347fa9b71167f80b9049283261634d"
  end

  def install
    libexec.install "acolyte"

    resource("launcher").stage do
      inreplace "launcher.sh" do |s|
        s.gsub! "__BASELINE_BIN__", "#{libexec}/acolyte"
        s.gsub! "__BASELINE_VERSION__", version.to_s
      end
      bin.install "launcher.sh" => "acolyte"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/acolyte --version")

    ENV["XDG_DATA_HOME"] = testpath/"data"
    staged = testpath/"data/acolyte/bin/99.0.0"
    staged.mkpath
    (staged/"acolyte").write "#!/bin/sh\necho staged\n"
    chmod 0755, staged/"acolyte"
    assert_equal "staged", shell_output(bin/"acolyte").chomp
  end
end
