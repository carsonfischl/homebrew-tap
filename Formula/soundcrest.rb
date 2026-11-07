class Soundcrest < Formula
  desc "Live waveform of whatever your Mac is playing"
  homepage "https://github.com/carsonfischl/soundcrest"
  url "https://github.com/carsonfischl/soundcrest/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "1ec3bf01cf0ab9526af6210954a310b0f4c24a8a8e8c5cd597ba36322edaef4f"
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
