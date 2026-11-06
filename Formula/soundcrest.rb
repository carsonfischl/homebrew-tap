class Soundcrest < Formula
  desc "Live waveform of whatever your Mac is playing"
  homepage "https://github.com/carsonfischl/soundcrest"
  url "https://github.com/carsonfischl/soundcrest/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "efe6c1ed4e5ce2d04b46a35c3c068dea238f32f8b91369bcc55f0ea7f9bbfca2"
  license "MIT"

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
