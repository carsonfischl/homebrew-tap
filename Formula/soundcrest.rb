class Soundcrest < Formula
  desc "Live waveform of whatever your Mac is playing"
  homepage "https://github.com/carsonfischl/soundcrest"
  url "https://github.com/carsonfischl/soundcrest/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "990887d26ab54764bc7db21a99bc9dee5509cd9bc6b753c53cb23a212fd74348"
  license "MIT"

  depends_on "tmux"
  depends_on macos: :sonoma

  uses_from_macos "swift" => :build

  def install
    odie "soundcrest requires macOS 14.2 or later" if MacOS.full_version < "14.2"

    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/soundcrest"
  end

  test do
    assert_match "usage: soundcrest", shell_output("#{bin}/soundcrest --help")
  end
end
