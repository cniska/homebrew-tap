class Acolyte < Formula
  desc "Terminal-first AI coding agent with an inspectable runtime"
  homepage "https://acolyte.sh"
  version "0.27.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/cniska/acolyte/releases/download/v0.27.0/acolyte-darwin-arm64.tar.gz"
      sha256 "425e21893b91a5081ef82aed694da1ccabe1f5f8e7612fe89c68789ebfb43b4b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/cniska/acolyte/releases/download/v0.27.0/acolyte-linux-x64.tar.gz"
      sha256 "bf04503387cb208fd9040814be7f7e8cfa9abcc75cad87aa27e09a9122547685"
    end
  end

  # The launcher execs the newest of this formula's binary and any build staged in the data
  # directory, so a self-update never writes into the Cellar and `brew upgrade` wins whenever
  # it is ahead.
  resource "launcher" do
    url "https://github.com/cniska/acolyte/releases/download/v0.27.0/launcher.sh"
    sha256 "f52834d87bddaa37fb458b58e0cde6385b6a79ba09f9fd612d37a23450da9196"
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
    assert_equal "staged", shell_output("#{bin}/acolyte").chomp
  end
end
